<?php

include 'Hasher.php';

$Msg = '123456789';

$Hasher = new Hasher('Adler-32');

$Hasher->Update($Msg, strlen($Msg));

$Hash = $Hasher->Finish();

echo $Hash;
