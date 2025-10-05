# === Twilio SMS GUI ===
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==== Twilio Config ====
$AccountSid = "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$AuthToken  = "your_auth_token"
$FromNumber = "+1234567890"  # Your Twilio number
# =======================

# --- Create GUI ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Twilio SMS Sender"
$form.Size = New-Object System.Drawing.Size(400,250)
$form.StartPosition = "CenterScreen"

$labelTo = New-Object System.Windows.Forms.Label
$labelTo.Text = "To Number:"
$labelTo.Location = New-Object System.Drawing.Point(20,30)
$form.Controls.Add($labelTo)

$textTo = New-Object System.Windows.Forms.TextBox
$textTo.Location = New-Object System.Drawing.Point(100,28)
$textTo.Width = 250
$form.Controls.Add($textTo)

$labelMsg = New-Object System.Windows.Forms.Label
$labelMsg.Text = "Message:"
$labelMsg.Location = New-Object System.Drawing.Point(20,70)
$form.Controls.Add($labelMsg)

$textMsg = New-Object System.Windows.Forms.TextBox
$textMsg.Location = New-Object System.Drawing.Point(100,68)
$textMsg.Width = 250
$textMsg.Height = 60
$textMsg.Multiline = $true
$form.Controls.Add($textMsg)

$buttonSend = New-Object System.Windows.Forms.Button
$buttonSend.Text = "Send Message"
$buttonSend.Location = New-Object System.Drawing.Point(140,150)
$form.Controls.Add($buttonSend)

# --- Button Action ---
$buttonSend.Add_Click({
    $ToNumber = $textTo.Text
    $Message = $textMsg.Text

    if (-not $ToNumber -or -not $Message) {
        [System.Windows.Forms.MessageBox]::Show("Please fill in both fields.")
        return
    }

    $uri = "https://api.twilio.com/2010-04-01/Accounts/$AccountSid/Messages.json"
    $body = @{
        To = $ToNumber
        From = $FromNumber
        Body = $Message
    }

    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -Credential (New-Object System.Management.Automation.PSCredential($AccountSid, (ConvertTo-SecureString $AuthToken -AsPlainText -Force)))
        [System.Windows.Forms.MessageBox]::Show("✅ Message sent successfully!")
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("❌ Failed to send message: $($_.Exception.Message)")
    }
})

$form.ShowDialog()
