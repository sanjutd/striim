$password = 'XXXXXXXXX' #Change Password here
$username = 'admin'
#curl -X POST -d'username=admin&password=******' http://localhost:9080/security/authenticate
Function getToken()
{ 
    $url = "http://10.160.32.69:9080/security/authenticate"  
    $method = "POST"
    $contentType = "application/x-www-form-urlencoded"
    $body = "username=$username&password=$password";
    $token = Invoke-WebRequest -Uri $url -Method $method -Body $body -ContentType $contentType -Verbose 
    write-host $token 
    return $token   
}

Function listApp()
{
    $token = getToken
    $token =  [string]$tokena
    $len = $token.length-2    
    $token = 'STRIIM-TOKEN '+$token.substring(10,36) 
    Write-Host $token -ForegroundColor Red
    $url = "http://10.160.32.69:9080/api/v2/applications"
    $method = "GET"
    $contentType = "application/json"
    $header =@{'Authorization'=$token;}        
    $output = Invoke-RestMethod -ContentType $contentType -Uri $url -Method $method -Headers $header -Verbose 
    $output = $output | ConvertTo-Json
    write-Host $output
}

Function getTemplate()
{
    $token = getToken
    $token =  [string]$token
    $len = $token.length-2    
    $token = 'STRIIM-TOKEN '+$token.substring(10,36) 
    Write-Host $token -ForegroundColor Red
    $templateName = 'INSIGHT2_5_exaunipb_dataload_Final'
    $url = "http://10.160.32.69:9080/api/v2/applications/templates/"+$templateName
    $method = "GET"
    $contentType = "application/json"
    $header =@{'Authorization'=$token;}        
    $output = Invoke-RestMethod -ContentType $contentType -Uri $url -Method $method -Headers $header -Verbose 
    $output = $output | ConvertTo-Json
    write-Host $output
    GET /applications/templates/{templateId}

}

listApp

