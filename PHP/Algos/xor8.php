<?php
//XOR-8
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class HasherXOR8 extends HasherBase
{
	protected $FHash = 0;

	public function __construct() 
	{
		$this->Check = '31';
		$this->FHash = 0;
	}

	public function Update($Msg, $Length)
	{
		for ($i=0; $i<$Length; $i++)
		{
			$this->FHash = $this->FHash ^ ord($Msg[$i]);
		}
	}

	public function Finish()
	{
		return sprintf('%02X', $this->FHash);
	}
}

$HasherList->RegisterHasher('XOR-8', 'HasherXOR8');