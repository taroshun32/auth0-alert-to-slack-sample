import { WebClient } from '@slack/web-api'

export async function notify(event) {

  const SLACK_BOT_TOKEN  = process.env.SLACK_BOT_TOKEN
  const SLACK_CHANNEL_ID = process.env.SLACK_CHANNEL_ID

  const client = new WebClient(SLACK_BOT_TOKEN)

  await client.chat.postMessage({
    channel: SLACK_CHANNEL_ID,
    blocks:  [
      {
        type: "section",
        text: {
          type: "mrkdwn",
          text: "```" + JSON.stringify(event.detail, null, 2) + "```"
        }
      }
    ]
  })
}
