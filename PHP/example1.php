<?php

include 'adler32.php';

$Msg = '123456789';

$Hasher = new HasherAdler32();

$Hasher->Update($Msg, strlen($Msg));

$Hash = $Hasher->Finish();

echo $Hash;
