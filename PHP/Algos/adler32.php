<?php
//Adler-32
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class HasherAdler32 extends HasherBase
{
	protected $FHash, $FHash2 = 0;

	public function __construct() 
	{
		$this->Check = '091E01DE';
		$this->FHash = 1;
		$this->FHash2 = 0;
	}

	public function Update($Msg, $Length)
	{
		$MOD_ADLER = 65521;
		
		for ($i=0; $i<$Length; $i++)
		{
			$this->FHash = ($this->FHash + ord($Msg[$i]) ) % $MOD_ADLER;
			$this->FHash2 = ($this->FHash2 + $this->FHash) % $MOD_ADLER;
		}
	}

	public function Finish()
	{
		$this->FHash = ($this->FHash2 << 16) | $this->FHash;
		return sprintf('%08X', $this->FHash);
	}
}

$HasherList->RegisterHasher('Adler-32', 'HasherAdler32');