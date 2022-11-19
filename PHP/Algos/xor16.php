<?php
//XOR-16
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class HasherXOR16 extends HasherBase
{
	protected $FHash = 0;

	public function __construct() 
	{
		$this->Check = '0839';
		$this->FHash = 0;
	}

	public function Update($Msg, $Length)
	{
		$L = 0;
		for ($i=0; $i<$Length; $i++)
		{
			$this->FHash = $this->FHash ^ (ord($Msg[$i]) << $L);
			
			$L += 8;
			if ($L == 32) $L = 0;		
		}
	}

	public function Finish()
	{
		$this->FHash = ($this->FHash & 0xFFFF) ^ ($this->FHash >> 16);
  
		return sprintf('%04X', $this->FHash);
	}
}

$HasherList->RegisterHasher('XOR-16', 'HasherXOR16');