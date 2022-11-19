<?php
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

require_once 'HasherBase.php';

class Hasher
{
	protected $Algo, $Class;

	public function __construct($Algo)
	{
		global $HasherList;
		
		$AClass = '';
		$Res = $HasherList->FindClass($Algo, $AClass);

		if (!$Res)
		{
			throw new Exception('Invalid algorithm');
		}

		$this->Class = $AClass;
		$this->Algo = new $AClass;
	} 

	public function Finish()
	{
		return $this->Algo->Finish();
	}

	public function Update($Msg, $Length)
	{
		$this->Algo->Update($Msg, $Length);
	}

	public function UpdateFile($Filename)
	{
		$Msg = file_get_contents($Filename);
		$this->Update($Msg, strlen($Msg) );
	}

	public function SelfCheck()
	{
		$Test = '123456789';

		try
		{
			$Algo = new $this->Class();
			$Algo->Update($Test, strlen($Test) );
			$Res = $Algo->Finish();

			if ($Algo->Check === $Res)
			{
				return true;
			}
		}
		finally
		{
		}

		return false;
	}
}

//autoload classes
//or you can just include the ones you want
foreach (glob('Algos/*.php') AS $fname)
{
	include $fname;
}