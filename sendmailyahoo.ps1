#check parameters
#status, usr, pwd
$nargs = $Args.Count
if($nargs -lt 3)
{
    #Write-Host "Falta argumento del script"
    exit
}


$argumento=$Args[0]
$usr=$Args[1]
$pwd=$Args[2]

if($argumento -eq "ok")
{
    $estado="Chromispos: OK Se realizo copia de seguridad correctamente!";
}
elseif($argumento -eq "local")
{
    $estado="Chromispos: WARNING: Sólo se realizo copia de seguridad local!";
}
elseif($argumento -eq "badjcifs")
{
    $estado="Chromispos: ERROR: No se pudo copiar backup a carpeta remota!";
}
elseif($argumento -eq "badchecknumcopies")
{
    $estado="Chromispos: ERROR: No se pudo realizar comprobracion numero de copias en carpeta remota!";
}
else
{
    $estado="Chromispos: ERROR al realizar copia de seguridad!";
}

#Clear Screen
cls Write-Host "Sending Email"

#SMTP server name
$smtpServer = "smtp.mail.yahoo.com"

#Creating a Mail object
$msg = new-object Net.Mail.MailMessage

#Email structure
$msg.From = $usr
$msg.To.Add($usr)
$msg.subject = "Chromispos Backup"
$msg.body = $estado

#Creating SMTP server object
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$smtp.EnableSsl = 1
$smtp.Port = 587
$cred = New-Object Net.NetworkCredential($usr,$pwd)
$smtp.Credentials = $cred

#Sending email
$smtp.Send($msg)
Write-Host "Correo Enviado!"