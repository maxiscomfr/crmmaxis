// Envoie une notification push à chaque nouvelle demande du site.
// Déclenchée par un Database Webhook sur l'insertion dans la table demandes.
import webpush from "npm:web-push@3.6.7";
import { createClient } from "npm:@supabase/supabase-js@2";

webpush.setVapidDetails(
  Deno.env.get("VAPID_SUBJECT")!,
  Deno.env.get("VAPID_PUBLIC_KEY")!,
  Deno.env.get("VAPID_PRIVATE_KEY")!,
);

Deno.serve(async (req) => {
  // Le webhook doit envoyer ce secret dans l'en-tête x-webhook-secret.
  if (req.headers.get("x-webhook-secret") !== Deno.env.get("WEBHOOK_SECRET")) {
    return new Response("forbidden", { status: 403 });
  }
  const payload = await req.json().catch(() => null);
  const id = payload?.record?.id ?? payload?.id;
  if (!id) return new Response("ignored", { status: 200 });

  const supabase = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
  // On relit la demande en base : le contenu de la notification ne vient jamais du corps de la requête.
  const { data: demande } = await supabase.from("demandes").select("id,nom,entreprise").eq("id", id).maybeSingle();
  if (!demande) return new Response("not found", { status: 404 });

  const { data: subs, error } = await supabase.from("push_abonnements").select("endpoint,p256dh,auth");
  if (error) return new Response("db error", { status: 500 });

  const message = JSON.stringify({
    id: demande.id,
    title: "Nouvelle demande",
    body: demande.nom + (demande.entreprise ? " · " + demande.entreprise : ""),
  });
  let sent = 0;
  for (const s of subs ?? []) {
    try {
      await webpush.sendNotification({ endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } }, message);
      sent++;
    } catch (e) {
      // Abonnement expiré ou supprimé côté navigateur : on le retire.
      if (e.statusCode === 404 || e.statusCode === 410) {
        await supabase.from("push_abonnements").delete().eq("endpoint", s.endpoint);
      }
    }
  }
  return new Response(JSON.stringify({ sent }), { headers: { "Content-Type": "application/json" } });
});
