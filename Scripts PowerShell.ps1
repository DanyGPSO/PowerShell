# Ajouter une APP Windows : Exemple la Visioneuse de Photos
Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

# Vérifier les packages Windows APPS
Get-AppxPackage -allusers | Select Name, PackageFullName

# Importer une photo d'un utilisateur AD
Set-ADUser si -Replace @{thumbnailPhoto=([byte[]](Get-Content "M:\DFSIQ\SI\Informatique\Annuaires\DFSIQ\si2018.jpg" -Encoding byte))}

# Exporter une photo d'un utilisateur AD
Import-Module ActiveDirectory

get-ADUser si
PS $user = Get-ADUser NomUtilisateur -Properties thumbnailPhoto
PS $user.thumbnailPhoto | Set-Content photo.jpg -Encoding byte

# Exporter les utilisateurs présent dans un groupe AD
Get-ADGroupMember -identity “Name of Group” -recursive | select name | Export-csv -path C:\Output\Groupmembers.csv -NoTypeInformation

# Exporter des informations de tous les utilisateurs AD dans un fichier CSV
Get-ADUser -Filter * -Properties Title,Department,LastLogonDate,whenCreated,Enabled |
Select SamAccountName,Title,Department,LastLogonDate,whenCreated,Enabled |
Export-Csv "C:\SIGPSO\ADusers2.csv" –NoTypeInformation

# Regarder le Quota utilisé dans une boite de messagerie Exchange
Get-MailboxStatistics "Nom Utilisateur" | Format-List StorageLimitStatus,TotalItemSize,TotalDeletedItemSize,ItemCount,DeletedItemCount

# Ajouter un Message d'Absence sur une boite de messagerie Exchange
Set-MailboxAutoReplyConfiguration cdani -AutoReplyState enabled -ExternalAudience all -InternalMessage "Bonjour je suis absente jusqu’au 24 août. En cas de nécessité, veuillez contacter M. GERIN Alexandre : alexandre.gerin@seineouest.fr / 01.46.29.29.55" -ExternalMessage "Bonjour je suis absente jusqu’au 24 août. En cas de nécessité, veuillez contacter M. GERIN Alexandre : alexandre.gerin@seineouest.fr / 01.46.29.29.55"

# Exporter tous les boite aux lettres avec le quota
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select DisplayName,TotalItemSize,TotalDeletedItemSize,ItemCount,DeletedItemCount | Export-CSV "C:\MAll Mailboxes.csv" -NoTypeInforma

# Lister les utilisateurs dans une base de données exchange
get-mailbox -database BALs_Utilisateurs-VIP
suivante Get-mailbox |Get-MailboxStatistics| select DisplayName,Database
