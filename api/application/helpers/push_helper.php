<?php



function enviarSMS($msg,$numero){
	$numero="5532998219412";

	$apiKey = "aRufj07s24-HW1er-4Owz1Su_SHzaZvg9dmc";

	$message = array('type' =>"text" ,'text' =>$msg);

	$url = 'https://api.zenvia.com/v2/channels/sms/messages';
	//reliable-recorder
	$sms = array("from"=>"glass-swim",
							 "to"=>$numero,
							 "contents" =>array($message));

	$headers = array('X-API-TOKEN:'. $apiKey,'Content-Type: application/json');
	$ch = curl_init();
	curl_setopt( $ch, CURLOPT_URL, $url );
	curl_setopt( $ch, CURLOPT_POST, true );
	curl_setopt( $ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
	curl_setopt( $ch, CURLOPT_POSTFIELDS, json_encode($sms) );
	$result = curl_exec($ch);
	curl_close($ch);

	return $result;

}
