<?php
//Author: domasz
//Version: 0.1 (2022-11-19)
//Licence: MIT

class HasherBase
{
	public $Check = ''; //hash of '123456789'
}

class HasherList
{
	protected $List = array();
	
	public function Count()
	{
		return count($this->List);
	}

	public function GetName($Index)
	{
		$keys = array_keys($this->List);

		if (($Index > count($keys)-1) or ($Index < 0)) return '';;

		return $keys[$Index];  
	}

	public function FindClass($Name, &$AClass)
	{
		$Name = strtolower($Name);

		$Index = isset($this->List[$Name]);

		if (!$Index)
		{
			return false;
		}

		$AClass = $this->List[$Name];
		return true;
	}

	public function RegisterHasher($Name, $AClass)
	{
		$Name = strtolower($Name);
		$this->List[$Name] = $AClass;
	}
}

$HasherList = new HasherList;