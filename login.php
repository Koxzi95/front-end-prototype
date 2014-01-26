<?php

    session_start();
    
    function getRealIp() {
       if (!empty($_SERVER['HTTP_CLIENT_IP'])) {  //check ip from share internet
         $ip=$_SERVER['HTTP_CLIENT_IP'];
       } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {  //to check ip is pass from proxy
         $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
       } else {
         $ip=$_SERVER['REMOTE_ADDR'];
       }
       return $ip;
    }

    function writeLog($where) {
    
    	$ip = getRealIp(); // Get the IP from superglobal
    	$host = gethostbyaddr($ip);    // Try to locate the host of the attack
    	$date = date("d M Y");
    	
    	// create a logging message with php heredoc syntax
    	$logging = <<<LOG
    		\n
    		<< Start of Message >>
    		There was a hacking attempt on your form. \n 
    		Date of Attack: {$date}
    		IP-Adress: {$ip} \n
    		Host of Attacker: {$host}
    		Point of Attack: {$where}
    		<< End of Message >>
LOG;
// Awkward but LOG must be flush left
    
            // open log file
    		if($handle = fopen('hacklog.log', 'a')) {
    		
    			fputs($handle, $logging);  // write the Data to file
    			fclose($handle);           // close the file
    			
    		} else {  // if first method is not working, for example because of wrong file permissions, email the data
    		
    			$to = 'ADMIN@gmail.com';  
            	$subject = 'HACK ATTEMPT';
            	$header = 'From: ADMIN@gmail.com';
            	if (mail($to, $subject, $logging, $header)) {
            		echo "Sent notice to admin.";
            	}
    
    		}
    }

    function verifyFormToken($form) {
        
        // check if a session is started and a token is transmitted, if not return an error
    	if(!isset($_SESSION[$form.'_token'])) { 
    		return false;
        }
    	
    	// check if the form is sent with token in it
    	if(!isset($_POST['token'])) {
    		return false;
        }
    	
    	// compare the tokens against each other if they are still the same
    	if ($_SESSION[$form.'_token'] !== $_POST['token']) {
    		return false;
        }
    	
    	return true;
    }
    
    function generateFormToken($form) {
    
        // generate a token from an unique value, took from microtime, you can also use salt-values, other crypting methods...
    	$token = md5(uniqid(microtime(), true));  
    	
    	// Write the generated token to the session variable to check it against the hidden field when the form is sent
    	$_SESSION[$form.'_token'] = $token; 
    	
    	return $token;
    }
    
    // VERIFY LEGITIMACY OF TOKEN
    if (verifyFormToken('form1')) {
    
        // CHECK TO SEE IF THIS IS A MAIL POST
        if (isset($_POST['URL-main'])) {
        
            // Building a whitelist array with keys which will send through the form, no others would be accepted later on
            $whitelist = array('token','req-name','req-email','typeOfChange','urgency','URL-main','addURLS', 'curText', 'newText', 'save-stuff', 'mult');
            
            // Building an array with the $_POST-superglobal 
            foreach ($_POST as $key=>$item) {
                    
                    // Check if the value $key (fieldname from $_POST) can be found in the whitelisting array, if not, die with a short message to the hacker
            		if (!in_array($key, $whitelist)) {
            			
            			writeLog('Unknown form fields');
            			die("Hack-Attempt detected. Please use only the fields in the form");
            			
            		}
            }
            
            
            
            
            
            
            // Lets check the URL whether it's a real URL or not. if not, stop the script
            
            if(!filter_var($_POST['URL-main'],FILTER_VALIDATE_URL)) {
            			writeLog('URL Validation');
            		die('Hack-Attempt detected. Please insert a valid URL');
            }
    
    
    
    
    
            // SAVE INFO AS COOKIE, if user wants name and email saved
            
            $saveCheck = $_POST['save-stuff'];
            if ($saveCheck == 'on') {
                setcookie("WRCF-Name", $_POST['req-name'], time()+60*60*24*365);
                setcookie("WRCF-Email", $_POST['req-email'], time()+60*60*24*365);
            }
            
            
            
            
            // PREPARE THE BODY OF THE MESSAGE

			$message = '<html><body>';
			$message .= '<img src="http://css-tricks.com/examples/WebsiteChangeRequestForm/images/wcrf-header.png" alt="Website Change Request" />';
			$message .= '<table rules="all" style="border-color: #666;" cellpadding="10">';
			$message .= "<tr style='background: #eee;'><td><strong>Name:</strong> </td><td>" . strip_tags($_POST['req-name']) . "</td></tr>";
			$message .= "<tr><td><strong>Email:</strong> </td><td>" . strip_tags($_POST['req-email']) . "</td></tr>";
			$message .= "<tr><td><strong>Type of Change:</strong> </td><td>" . strip_tags($_POST['typeOfChange']) . "</td></tr>";
			$message .= "<tr><td><strong>Urgency:</strong> </td><td>" . strip_tags($_POST['urgency']) . "</td></tr>";
			$message .= "<tr><td><strong>URL To Change (main):</strong> </td><td>" . $_POST['URL-main'] . "</td></tr>";
			$addURLS = $_POST['addURLS'];
			if (($addURLS) != '') {
			    $message .= "<tr><td><strong>URL To Change (additional):</strong> </td><td>" . strip_tags($addURLS) . "</td></tr>";
			}
			$curText = htmlentities($_POST['curText']);           
			if (($curText) != '') {
			    $message .= "<tr><td><strong>CURRENT Content:</strong> </td><td>" . $curText . "</td></tr>";
			}
			$message .= "<tr><td><strong>NEW Content:</strong> </td><td>" . htmlentities($_POST['newText']) . "</td></tr>";
			$message .= "</table>";
			$message .= "</body></html>";
			
			
			
			
			//  MAKE SURE THE "FROM" EMAIL ADDRESS DOESN'T HAVE ANY NASTY STUFF IN IT
			
			$pattern = "/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/i"; 
            if (preg_match($pattern, trim(strip_tags($_POST['req-email'])))) { 
                $cleanedFrom = trim(strip_tags($_POST['req-email'])); 
            } else { 
                return "The email address you entered was invalid. Please try again!"; 
            } 
			
			
            
            
            //   CHANGE THE BELOW VARIABLES TO YOUR NEEDS
             
			$to = 'JUNKKKKK@gmail.com';
			
			$subject = 'Website Change Reqest';
			
			$headers = "From: " . $cleanedFrom . "\r\n";
			$headers .= "Reply-To: ". strip_tags($_POST['req-email']) . "\r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

            if (mail($to, $subject, $message, $headers)) {
              echo 'Your message has been sent.';
            } else {
              echo 'There was a problem sending the email.';
            }
            
            // DON'T BOTHER CONTINUING TO THE HTML...
            die();
        
        }
    } else {
    
   		if (!isset($_SESSION[$form.'_token'])) {
   		
   		} else {
   			echo "Hack-Attempt detected. Got ya!.";
   			writeLog('Formtoken');
   	    }
   
   	}

?>