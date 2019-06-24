//trace("__type:" + __type + " __arg0:" + __arg0 + " __arg1:" + __arg1);
// __arg0 => card-type : int
// __arg1 => card-level : int

// To change each unit stat refer to this table :
// range - splash - quantity - health - damage - speed
//
//      r - s - q - h - d - s
// 101	H - 0 - 0 - L - L - L
// 102	L - 0 - 0 - H - L - L
// 103	0 - 0 - H - L - L - M
// 104	L - H - 0 - M - L - L
// 105	0 - 0 - 0 - M - H - L
// 106	H - M - 0 - L - L - L
// 107	L - H - 0 - L - L - M
// 108	M - 0 - L - L - L - M
// 109	M - M - 0 - L - L - M
// 110	L - 0 - M - L - L - M
// 111	L - H - L - M - L - L
// 112	L - 0 - H - M - L - L
// 113	L - 0 - 0 - M - M - L
// 114	0 - 0 - M - L - L - M
//
// 151  0 - M - 0 - 0 - M - 0	
// 152	0 - H - 0 - 0 - L - 0
//
// 201	
// 221	
// 222 


if( __type == -3 )
{
	return switch( __arg0 )
	{
		case	101	:[	105 ,  113 , 103 , 112 , 106 , 151 , 110 , 108 , 102 , 101 , 107 , 111 , 152 , 104 , 109	];
		case	102	:[	103 ,  112 , 101 , 108 , 110 , 105 , 106 , 113 , 111 , 102 , 107 , 104 , 151 , 152 , 109	];
		case	103	:[	151 ,  152 , 106 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109	];
		case	104	:[	101 ,  105 , 108 , 113 , 107 , 106 , 104 , 102 , 112 , 151 , 152 , 111 , 103 , 110 , 109	];
		case	105	:[	103 ,  110 , 112 , 101 , 106 , 108 , 113 , 102 , 105 , 111 , 104 , 107 , 151 , 152 , 109 	];
		case	106	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152	];
		case	107	:[	102 ,  105 , 101 , 113 , 108 , 151 , 152 , 106 , 107 , 111 , 110 , 112 , 103 , 104 , 109	];
		case	108	:[	105 ,  113 , 101 , 102 , 106 , 107 , 108 , 112 , 111 , 103 , 104 , 151 , 152 , 110 , 109	];
		case	110	:[	152 ,  106 , 151 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109	];
		case	111	:[	101 ,  105 , 108 , 113 , 107 , 106 , 104 , 102 , 112 , 151 , 152 , 111 , 103 , 110 , 109	];
		case	112	:[	151 ,  152 , 106 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109	];
		case	113	:[	103 ,  110 , 101 , 108 , 112 , 105 , 106 , 113 , 111 , 102 , 107 , 104 , 151 , 152 , 109	];
		case	114	:[	151 ,  152 , 106 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109	];
		case	115	:[	101 ,  105 , 108 , 113 , 107 , 106 , 104 , 102 , 112 , 151 , 152 , 111 , 103 , 110 , 109	];

		default   :[ -1 ];
	}
}

// version
if( __type == -2 )
{
	return 2100;
}

// chance
if( __type == -1 )
{
	return switch( __arg0 )
	{
		case	101	:	0	;
		case	102	:	0	;
		case	103	:	0	;
		case	104	:	0	;
		case	105	:	0	;
		case	106	:	0	;
		case	107	:	0	;
		case	108	:	1	;
		case	109	:	4	;
		case	110	:	12;
		case	111	:	18;
		case	112	:	30;
		case	113	:	40;
		case	114	:	40;
		case	115	:	0	;
		
		case	151	:	8	;
		case	152	:	10	;
		
		default		:	1000;
	}
}

// rarity
if( __type == 0 )
{
	return switch( __arg0 )
	{
		case	101	:	 0	;
		case	102	:	 0	;
		case	103	:	 0	;
		case	104	:	 1	;
		case	105	:	 0	;
		case	106	:	 0	;
		case	107	:	 2	;
		case	108	:	 1	;
		case	109	:	 0	;
		case	110	:	 0	;
		case	111	:	 0	;
		case	112	:	 0	;
		case	113	:	 0	;
		case	114	:	 0	;
		case	115	:	 1	;
		
		case	151	:	 1	;
		case	152	:	 0	;
		case	153	:	 0	;
		case	154	:	 1	;
		case	155	:	 1	;
		case	156	:	 2	;
		case	157	:	 0	;
		case	158	:	 1	;
		case	159	:	 2	;
		
		default		:	 0	;
	}
}

// availableAt
if( __type == 1 )
{
	var all = [108,109,151,110,111,152,112,113,153,114,154,115,116,155,117,118,119,156,120,121,122,123,157,124,125,126,127,128,158,129,130,159];
	if( __arg0 == -1 )
	{
		all.unshift(107);
		all.unshift(106);
		all.unshift(105);
		all.unshift(104);
		all.unshift(103);
		all.unshift(102);
		all.unshift(101);
		return all;
	}
	var index = 0;
	for( c in all )
	{
		if( c == __arg0 )
			return index;
		index ++;
	}
	return 0;
}


// elixirSize
if( __type == 2 )
{
	return switch( __arg0 )
	{
		case 101 :	4	;
		case 102 :	5	;
		case 103 :  4	;
		case 104 :  3	;
		case 105 :  5	;
		case 106 :  4	;
		case 107 :  4	;
		case 108 :  3	;
		case 109 :  4	;
		case 110 :  2	;
		case 111 :  6	;
		case 112 :  4	;
		case 113 :  2	;
		case 114 :  3	;
		case 115 :  3	;

		case 151 :  4	;
		case 152 :  3	;

		default	 :  2	;
	}
	//return ret;
}


// quantity
// H = 4 and higher
// M = 3
// L = 2
if( __type == 3 )
{
	return switch( __arg0 )
	{
		case	101	:	 1	;
		case	102	:	 1	;
		case	103	:	 12	;
		case	104	:	 1	;
		case	105	:	 1	;
		case	106	:	 1	;
		case	107	:	 1	;
		case	108	:	 2	;
		case	109	:	 1	;
		case	110	:	 3	;
		case	111	:	 2	;
		case	112	:	 4	;
		case	113	:	 1	;
		case	114	:	 3	;
		case	115	:	 1	;

		
		case	151	:	 1	;
		case	152	:	 1	;
		
		case	201	:	 1	;
		
		default: 		 1	;
	}
	return ret;
}

// summonTime
if( __type == 4 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	 0.8	;
		case	102	:	 1.0	;
		case	103	:	 1.0	;
		case	104	:	 1.0	;
		case	105	:	 1.2	;
		case	106	:	 1.0	;
		case	107	:	 1.0	;
		case	108	:	 1.0	;
		case	109	:	 1.0	;
		case	110	:	 1.0	;
		case	111	:	 1.0	;
		case	112	:	 0.8	;
		case	113	:	 0.8	;
		case	114	:	 1.0	;
		case	115	:	 1.0	;

		
		case	151	:	 2.0	;
		case	152	:	 0.7	;
		
		default 	: 	 0.0	;
	}
	ret *= 1000;
	return ret;
}

// speed
if( __type == 11 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.70;
		case	102	:	0.60;
		case	103	:	1.10;
		case	104	:	0.90;
		case	105	:	0.80;
		case	106	:	0.70;
		case	107	:	1.10;
		case	108	:	1.00;
		case	109	:	0.80;
		case	110	:	1.10;
		case	111	:	1.00;
		case	112	:	0.70;
		case	113	:	0.60;
		case	114	:	1.10;
		case	115	:	0.90;

		
		case	201	:	0.00;
		case	221	:	1.20;
		case	222	:	1.10;
		case	223	:	1.30;
		
		
		default		:	1.00;
	}
	return ret * 0.085 * 1.1;
}

// health
// H = min 2.0 , max ~    
// M = min 1.0 , max 1.8  
// L = min 0.1 , max 0.8
if( __type == 12 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.50;
		case	102	:	3.00;
		case	103	:	0.15;
		case	104	:	1.00;
		case	105	:	1.40;
		case	106	:	0.50;
		case	107	:	0.30;
		case	108	:	0.80;
		case	109	:	0.30;
		case	110	:	0.10;
		case	111	:	1.00;
		case	112	:	1.00;
		case	113	:	1.30;
		case	114	:	0.60;
		case	115	:	1.00;

		
		case	201	:	5.00;
		case	221	:	6.00;
		case	222	:	2.70;
		case	223	:	2.50;
		
		
		default		:	1.00;
	}
	return (ret * Math.pow(1.095, __arg1 - 1)) * 1.5;
}

// sizeH
if( __type == 13 )
{
	var ret = return switch( __arg0 )
	{
		case	101	:	15	;
		case	102	:	45  ;
		case	103	:	5		;
		case	104	:	25	;
		case	105	:	35	;
		case	106	:	13	;
		case	107	:	45	;
		case	108	:	15	;
		case	109	:	40	;
		case	110	:	13	;
		case	111	:	25	;
		case	112	:	25	;
		case	113	:	20	;
		case	114	:	10	;
		case	115	:	25	;

		
		case	201	:	40	;
		case	221	:	30	;
		case	222	:	40	;
		case	223	:	25	;
		
		default		:	10	;
	}
	
	return ret * 20.00;
}

// sizeV
if( __type == 14 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.50;
		case	102	:	0.55;
		case	103	:	0.35;
		case	104	:	0.50;
		case	105	:	0.45;
		case	106	:	0.50;
		case	107	:	0.40;
		case	108	:	0.60;
		case	109	:	1.00;
		case	110	:	0.35;
		case	111	:	0.50;			
		case	112	:	0.50;
		case	113	:	0.50;
		case	114	:	0.35;
		case	115	:	0.50;

		case	151	:	1.00;

		case	201	:	0.90;
		case	221	:	0.90;
		case	222	:	0.90;
		case	223	:	0.50;
		
		default		:	1.00;
	}
	return ret * 100;
}

// focusRange
if( __type == 15 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	1.8 ;
		case	102	:	1.0	;
		case	103	:	1.0	;
		case	104	:	1.0	;
		case	105	:	1.0	;
		case	106	:	1.6	;
		case	107	:	1.0	;
		case	108	:	1.4	;
		case	109	:	1.0	;
		case	110	:	1.0	;
		case	111	:	1.0	;
		case	112	:	1.2 ;
		case	113	:	1.2 ;
		case	114	:	1.0	;
		case	115	:	1.0	;

		
		case 	201 : 1.5 ;
		case 	221 :	1.6 ;
		case	222	:	1.9	;
		case	223	:	1.6	;
		
		
		default		:	1.0	;
	}
	return ret * 350;
}

// explosive
if( __type == 16 )
{
	return switch( __arg0 )
	{
		case	107	:	true;
		default		:	false;
	}
}


// bulletSpeed
if( __type == 21 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	3.0	;
		case	102	:	0.9	;
		case	103	:	1.3	;
		case	104	:	1.6	;
		case	105	:	1.0	;
		case	106	:	0.5	;
		case	107	:	1.0	;
		case	108	:	2.0	;
		case	109	:	2.0	;
		case	110	:	1.4	;
		case	111	:	1.6	;
		case	112	:	1.5	;
		case	113	:	1.5	;
		case	114	:	1.3	;
		case	115	:	1.6	;

		
		case	151	:	1.2 ;
		case	152	:	0.8	;
		
		case	201	:	1.5	;
		case	221	:	1.5	;
		case	222	:	2.2	;
		case	223	:	1.5	;
		
		default		:	1.0	;
	}
	return ret * 22.0;
}

// bulletDamage
// (Damage/s). Inform amin if you heading to change this one. Becuase "Damage" related to "Gap".
// H = min 0.30 , max 0.50  
// M = min 0.20 , max 0.29  
// L = min 0.05 , max 0.19 
// Spells must divide by 3 
if( __type == 22 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.30;
		case	102	:	0.30;
		case	103	:	0.04;
		case	104	:	0.24	;
		case	105	:	0.68	;
		case	106	:	0.16	;
		case	107	:	0.60	;
		case	108	:	0.07	;
		case	109	:-0.08	;
		case	110	: 0.10	;
		case	111	: 0.24	;
		case	112	:	0.10	;
		case	113	:	0.20	;
		case	114	:	0.12	;
		case	115	:	0.24	;
		
		case	151	:	0.70	;
		case	152	:	0.40 	;
		
		case	201	:	0.06	;
		case	221	:	0.20	;
		case	222	:	0.17	;
		case	223	:	0.16	;
		
		
		default		:	1.00	;
	}
	return (ret * Math.pow(1.095, __arg1 - 1));
}

// bulletShootGap
if( __type == 23 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	2.0 ;
		case	102	:	1.8	;
		case	103	:	0.7	;
		case	104	:	1.3	;
		case	105	:	1.7 ;
		case	106	:	1.5 ;
		case	107	:	9.0	;
		case	108	:	0.6	;
		case	109	:	1.0	;
		case	110	:	0.7	;
		case	111	:	1.3	;
		case	112	:	0.7	;
		case	113	:	0.8	;
		case	114	:	0.7	;
		case	115	:	1.3	;

		
		case 	201 :	1.0 ;
		case 	221 :	1.0 ;
		case 	222 :	1.0 ;
		case 	223 :	0.7 ;
		
		default		:	1.0 ;
	}
	return 	ret * 750 ;
}

// bulletShootDelay
if( __type == 24 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.0	;
		case	102	:	0.7	;
		case	103	:	0.7	;
		case	104	:	0.5	;
		case	105	:	0.0	;
		case	106	:	0.5	;
		case	107	:	0.0	;
		case	108	:	0.0	;
		case	109	:	0.5	;
		case	110	:	0.7	;
		case	111	:	0.5	;
		case	112	:	0.4 ;
		case	113	:	0.4 ;
		case	114	:	0.7	;
		case	115	:	0.5	;

		case	201	:	0.5	;
		case	221	:	0.5	;
		case	222	:	0.5	;
		case	223	:	0.5	;
		
		default		:	1.0;
	}
	return ret * 700 ;
}

// bulletRangeMin
if( __type == 25 )
{
	return 0;
}

// bulletRangeMax
// H = min 1.5 , max 1.8
// M = min 1.0 , max 1.4
// L = min 0.6 , max 0.9
// melee = min 0.1 , max 0.5 
if( __type == 26 )
{
	var ret =  switch( __arg0 )
	{
		case	101	:	1.8 	;
		case	102	:	0.9		;
		case	103	:	0.55	;
		case	104	:	0.9		;
		case	105	:	0.5		;
		case	106	:	1.6		;
		case	107	:	0.1		;
		case	108	:	1.4		;
		case	109	:	1.0		;
		case	110	:	0.8		;
		case	111	:	0.9		;
		case	112	:	0.4 	;
		case	113	:	0.4 	;
		case	114	:	0.4		;
		case	115	:	0.9		;

		
		case 	201 : 1.5 	;
		case 	221 : 0.5 	;
		case 	222 : 1.4 	;
		case 	223 : 0.4 	;
		
		
		default		:	1.0;
	}
	return ret * 300;
}

// bulletDamageArea
//H = min 12 , max ~
//M = min 5.0 , max 10 
//L = min 0.7 , max 1.0
if( __type == 27 )
{
	var ret =  switch( __arg0 )
	{
		case	101	:	0.50	;
		case	102	:	0.50	;
		case	103	:	0.50	;
		case	104	:	10.0	;
		case	105	:	0.50	;
		case	106	:	18.0	;
		case	107	:	20.0	;
		case	108	:	0.50	;
		case	109	:	9.00	;
		case	110	:	0.50	;
		case	111	:	12.0	;
		case	112	:	0.50	;
		case	113	:	0.50	;
		case	114	:	0.50	;
		case	115	:	12.0	;

		
		case	151	:	17.0	;
		case	152	:	20.0	;
		
		case 	201 :	0.50 	;
		case 	221 :	1.00 	;
		case 	222 :	0.50 	;
		case	223	:	0.50	;
		
		default 	:	1.00	;
	}
	return ret * 10;
}

// bulletExplodeDelay
if( __type == 28 )
{
	return switch( __arg0 )
	{
		case	106	:	0	;
		default		:	0	;
	}
}

// force kill
if( __type == 29 )
{
	return switch( __arg0 )
	{
		case	101	:	true;
		case	105	:	true;
		case	112	:	true;
		case	113	:	true;
		case	201	:	true;
		case	221	:	true;
		case	222	:	true;
		default		:	false;
	}
}


// =================== Challenges ====================== 

// getMode(index:Int) : Int
if( __type == 41 )
{
	return switch( __arg0 )
	{
		case 0:		__arg1 % 2 == 0 ? 0 : 1;
		case 1:		__arg1 % 2 == 0 ? 1 : 0;
		case 2:		2;
		case 3:		3;
		default:	0;
	}
}

// getType(index:Int) : Int
if( __type == 42 )
{
	return switch( __arg0 )
	{
		case 1:		1;
		case 2:		1;
		case 3:		2;
		default:	0;
	}
}

// getUnlockAt(index:Int) : Int
if( __type == 43 )
{
	return switch( __arg0 )
	{
		case 1:		1;
		case 2:		8;
		case 3:		20;
		default:	0;
	}
}

// getCapacity(type:Int):Int
if( __type == 44 )
{
	return switch( __arg0 )
	{
		case 2:		100;
		default:	0;
	}
}

// getWaitTime(type:Int) 
if( __type == 45 )
{
	return switch( __arg0 )
	{
		case 2:		3600 * 24;
		default:	0;
	}
}

// getDuration(type:Int):Int
if( __type == 46 )
{
	return switch( __arg0 )
	{
		case 1:		3600 * 24;
		case 2:		3600 * 72;
		default:	0;
	}
}

// getElixirSpeed(mode:Int, rageMode:Bool) : Float
if( __type == 47 )
{
	return switch( __arg0 )
	{
		case 2:		__arg1 ? 3 : 2;
		default:	__arg1 ? 2 : 1;
	}
}

// getRewardCoef(type:Int) : Float
if( __type == 48 )
{
	return switch( __arg0 )
	{
		case 1:		1;
		case 2:		2;
		default:	0;
	}
}

// getJoinRequiements(type:Int):IntIntMap
if( __type == 51 )
{
	return switch( __arg0 )
	{
		//case 1:		ret.set(ResourceType.R4_CURRENCY_HARD, 0);
		default:	"";//"4:0";
	}
}

// getRunRequiements(type:Int):IntIntMap
if( __type == 52 )
{
	return switch( __arg0 )
	{
		case 1:		"6:1";
		case 2:		"6:2";
		case 3:		"6:3";
		default:	"6:0";
	}
}
// =================== BATTLES ====================== 

//numtutorBattles(mode:Int) : Int
if( __type == 61 )
{
	return switch( __arg0 ) // mode
	{
		case 0	: 3;
		default	:	3;
	}
}

//numCovers(mode:Int, battleWins:Int) : Int
if( __type == 62 )
{
	if( __arg0 == 0 ) // mode 0
	return switch( __arg1 ) // battleWins
	{
		case 0	: 1;
		default	:	1;
	}

	// mode 1
	return switch( __arg1 )
	{
		case 0	: 1;
		default	:	1;
	}
}

//numRound(mode:Int, battleWins:Int) : Int
if( __type == 63 )
{
	// mode 0
	if( __arg0 == 0 )
	return switch( __arg1 )
	{
		case 0	: 2;
		default	:	2;
	}

	// mode 1
	return switch( __arg1 )
	{
		case 0	: 2;
		default	:	2;
	}
}

// getPauseTime(mode:Int, battleWins:Int, numSummonedUnits:Int) : Int
if( __type == 64 )
{
	if( __arg2 == 1 ) // numSummonedUnits
	{
		// mode 0
		if( __arg0 == 0 )
		return switch( __arg1 )
		{
			case 0	: 1000;
			case 1	: 1300;
			default	:	0;
		}

		// mode 1
		return switch( __arg1 )
		{
			case 0	: 1000;
			case 1	: 1300;
			case 2	: 1300;
			default	:	0;
		}
	}

	if( __arg2 == 2 ) // numSummonedUnits
		return 2000000;
	return 0;
}

// summonPos(mode:Int, type:String, battleIndex*10+numSummonedUnits:Int):Array
if( __type == 66 )
{
	// mode 0
	if( __arg0 == 0 ) // mode 0
	{
		if( __arg1 == "start" )
		return switch( __arg2 )
		{
		// (deck-card-index, x-pos, y-pos, delay)
			case 0	: [0, 200, 1250, 500];
			case 1	:	[0, 200, 1300, 500];
			case 2	: [1, 200, 1300, 500];
			default	:	null;
		}

		if( __arg1 == "cover" )
		return switch( __arg2 )
		{
			case 1	: [2, 300, 1450, 2000];
			case 11	:	[1, 300, 1200, 2000];
			case 21	: [1, 300, 1200, 2000];
			default:	null;
		}

		if( __arg1 == "newround" )
		return switch( __arg2 )
		{
			case 0	: [1, 450, 850, 200];
			case 1	:	[1, 450, 900, 200];
			case 2	: [1, 450, 900, 200];
			default:	null;
		}
	}

	// mode 1
	if( __arg1 == "start" )
	return switch( __arg2 )
	{
		case 0	: [1, 350, 1400, 500];
		case 1	:	[1, 650, 1400, 500];
		case 2	: [0, 500, 1400, 500];
		default:	null;
	}

	if( __arg1 == "cover" )
	return switch( __arg2 )
	{
		case 1	: [1, 700, 1400, 2000];
		case 11	:	[3, 600, 1500, 2000];
		case 12	:	[2, 600, 1500, 2000];
		case 21	: [2, 600, 1400, 2000];
		case 22	: [2, 700, 1500, 2000];
		default:	null;
	}

	if( __arg1 == "newround" )
	return switch( __arg2 )
	{
		case 0	: [1, 540, 1400, 3000];
		case 1	:	[3, 540, 1500, 3000];
		case 2	: [2, 540, 1500, 3000];
		default:	null;
	}
	return null;
}

return 0;