<?php
//Fletcher-32
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class HasherFletcher8 extends HasherBase
{
	protected $FHash, $FHash2 = 0;

	public function __construct() 
	{
		$this->Check = '0C';
		$this->FHash = 0;
		$this->FHash2 = 0;
	}

	public function Update($Msg, $Length)
	{
		for ($i=0; $i<$Length; $i++)
		{
			$this->FHash = ($this->FHash + ord($Msg[$i]) ) % 15;
			$this->FHash2 = ($this->FHash2 + $this->FHash) % 15;
		}
	}

	public function Finish()
	{
		$this->FHash = ($this->FHash2 << 4) | $this->FHash;
		return sprintf('%02X', $this->FHash);
	}
}

$HasherList->RegisterHasher('Fletcher-8', 'HasherFletcher8');