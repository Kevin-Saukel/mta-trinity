<?php 
	
	
	class StringUtility {
		public static function Multiply ( $stringToMultiply, $amount, $seperatingCharacter = "" )
		{
			$NewString = ""
					
			for ($i = 1; $i <= $amount; $i++) 
			{
				if ( $i == $amount ) {
					$NewString = $NewString . $StringToMultiply;
					break
				}
				$NewString = $NewString . $StringToMultiply . $seperatingCharacter;
			}
			return $NewString
		}
	}
?>