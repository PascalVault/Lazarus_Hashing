<?php
//Fletcher-32
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class HasherFletcher16 extends HasherBase
{
	protected $FHash, $FHash2 = 0;

	public function __construct() 
	{
		$this->Check = '1EDE';
		$this->FHash = 0;
		$this->FHash2 = 0;
	}

	public function Update($Msg, $Length)
	{
		for ($i=0; $i<$Length; $i++)
		{
			$this->FHash = ($this->FHash + ord($Msg[$i]) ) % 255;
			$this->FHash2 = ($this->FHash2 + $this->FHash) % 255;
		}
	}

	public function Finish()
	{
		$this->FHash = ($this->FHash2 << 8) | $this->FHash;
		return sprintf('%04X', $this->FHash);
	}
}

$HasherList->RegisterHasher('Fletcher-16', 'HasherFletcher16');