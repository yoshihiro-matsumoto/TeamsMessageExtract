function Export-TeamsMessagesAndReplies {  
    param (
        $ExportPath,
        $TeamId,
        $ChannelId,
        $AccessToken,
        $QueryFilter
    )  
    process {
        $messageList = Invoke-RestMethod -Headers @{Authorization = "Bearer $AccessToken" } -Uri https://graph.microsoft.com/beta/teams/$TeamId/channels/$ChannelId/messages -Method Get
        $userList = Invoke-RestMethod -Headers @{Authorization = "Bearer $AccessToken"} -Uri https://graph.microsoft.com/v1.0/users?$QueryFilter -Method Get
        $repliesList = @()

        foreach ($message in $messageList.value) {
            $message_id = $message.id
            Try {
                $replies = Invoke-RestMethod -Headers @{Authorization = "Bearer $AccessToken" } -Uri https://graph.microsoft.com/beta/teams/$TeamId/channels/$ChannelId/messages/$message_id/replies -Method Get
            }
            Catch {

            }
            $repliesList += $replies.value
        }

        $userList.value | ConvertTo-Json -Depth 10 | Out-File $ExportPath\\User.json
        $messageList.value | ConvertTo-Json -Depth 10 | Out-File $ExportPath\\Messages.json
        $repliesList | ConvertTo-Json -Depth 10 | Out-File $ExportPath\\Replies.json
    }
}

# Export-TeamsMessagesAndReplies -ExportPath "." -TeamId "<your teams id>" -ChannelId "<your channel id>" `
#                                -QueryFilter "`$filter=Department eq '<your department>'" `
#                                -AccessToken "<your access token for graph api>"
