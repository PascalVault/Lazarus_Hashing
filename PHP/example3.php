<?php

include 'Hasher.php';	

for ($i=0; $i<$HasherList->Count(); $i++)
{
	$Algo = $HasherList->GetName($i);

	$Hasher = new Hasher($Algo);
	if ($Hasher->SelfCheck())
	{
		echo "$Algo: OK<br>";
	}
}
