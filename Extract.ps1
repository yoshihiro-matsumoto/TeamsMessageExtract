function Export-TeamsMessagesAndReplies {  
    param (
        $ExportMessagePath,
        $ExportRepliesPath,
        $TeamId,
        $ChannelId,
        $AccessToken
    )  
    process {
        $messageList = Invoke-RestMethod -Headers @{Authorization = "Bearer $AccessToken" } -Uri https://graph.microsoft.com/beta/teams/$TeamId/channels/$ChannelId/messages -Method Get
        $repliesList = @()

        foreach ($message in $messageList.value) {
            $message_id = $message.id
            Try {
                $replies = Invoke-RestMethod -Headers @{Authorization = "Bearer $AccessToken" } -Uri https://graph.microsoft.com/beta/teams/$TeamId/channels/$ChannelId/messages/$message_id/replies -Method Get
            }
            Catch {

            }
            $repilesList += $replies.value
        }

        $messageList.value | ConvertTo-Json | Out-File $ExportMessagePath
        $repilesList | ConvertTo-Json | Out-File $ExportRepliesPath
    }
}

Export-TeamsMessagesAndReplies -ExportMessagePath ".\Messages.json" -ExportRepliesPath ".\Replies.json" -TeamId "<your team guid>" -ChannelId "<your channel id>" -AccessToken "<your access token>"
