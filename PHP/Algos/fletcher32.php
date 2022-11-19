<?php
//Fletcher-32
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class HasherFletcher32 extends HasherBase
{
	protected $FHash, $FHash2 = 0;

	public function __construct() 
	{
		$this->Check = '091501DD';
		$this->FHash = 0;
		$this->FHash2 = 0;
	}

	public function Update($Msg, $Length)
	{
		for ($i=0; $i<$Length; $i++)
		{
			$this->FHash = ($this->FHash + ord($Msg[$i]) ) % 65535;
			$this->FHash2 = ($this->FHash2 + $this->FHash) % 65535;
		}
	}

	public function Finish()
	{
		$this->FHash = ($this->FHash2 << 16) | $this->FHash;
		return sprintf('%08X', $this->FHash);
	}
}

$HasherList->RegisterHasher('Fletcher-32', 'HasherFletcher32');