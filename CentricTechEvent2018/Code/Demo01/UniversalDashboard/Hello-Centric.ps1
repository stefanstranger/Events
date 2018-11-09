$CentricDashboard = New-UDDashboard -Title "Hello Centric - Awesome session" -Content {
    New-UDCard -Title 'Centric Tech Event 2018 - Infrastructure-track' -Image (New-UDImage -Url 'https://www.centric.eu/media/d02c184e-6f5d-40ed-a61f-593947b5f64f/6Bh_qg/Events/Netherlands/EventPhotos/Craft/Tech%20event%202018/bnr-TEX-mail.jpg') -Content {
        'Infrastructure as Code door Stefan Stranger (Microsoft)'
    } -Links @(
        New-UDLink -Text 'Sessie informatie' -Url 'https://www.centric.eu/NL/Default/Craft/Tech-event-2018---Infrastructure-track'
    )
}
Start-UDDashboard -Port 8585 -Dashboard $CentricDashboard -Name 'HelloCentricDashboard' -Wait