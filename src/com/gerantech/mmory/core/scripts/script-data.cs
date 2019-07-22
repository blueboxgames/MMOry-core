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
		case	116	:	0	;

		
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
		case	116	:	 1	;
		
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

// elixirSize
if( __type == 2 )
{
	return switch( __arg0 )
	{
		case 101 :	4	;
		case 102 :	5	;
		case 103 :  3	;
		case 104 :  4	;
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
		case 115 :  5	;
		case 116 :  5	;	

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
		case	116	:	 1	;
	
		
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
		case	107	:	 1.5	;
		case	108	:	 1.0	;
		case	109	:	 1.0	;
		case	110	:	 1.0	;
		case	111	:	 1.0	;
		case	112	:	 0.8	;
		case	113	:	 0.8	;
		case	114	:	 1.0	;
		case	115	:	 2.0	;
		case	116	:	 2.0	;	

		
		case	151	:	 2.0	;
		case	152	:	 0.7	;
		
		default 	: 	 0.0	;
	}
	ret *= 1000;
	return ret;
}

// z
if( __type == 10 )
{
	return ret = switch( __arg0 )
	{
		case	101	:	300;
		default		:	0;
	}
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
		case	107	:	1.40;
		case	108	:	1.00;
		case	109	:	0.80;
		case	110	:	1.10;
		case	111	:	1.00;
		case	112	:	0.70;
		case	113	:	0.60;
		case	114	:	1.10;
		case	115	:	0.60;
		case	116	:	0.00;

		
		case	201	:	0.00;
		case	221	:	1.20;
		case	222	:	1.10;
		case	223	:	1.30;
		
		
		default		:	0.00;
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
		case	107	:	0.50;
		case	108	:	0.80;
		case	109	:	0.30;
		case	110	:	0.30;
		case	111	:	1.00;
		case	112	:	1.00;
		case	113	:	1.30;
		case	114	:	0.80;
		case	115	:	3.50;
		case	116	:	1.80;

		
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
		case	103	:	5	;
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
		case	116	:	50	;	

		
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
		case	116	:	0.55;	

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
		case	116	:	1.6	;

		
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

// focus unit (Building only target)
if( __type == 17 )
{
	return switch( __arg0 )
	{
		case	107	:	false;
		case	115	:	false;
		default		:	true;
	}
}

// focus height ()
if( __type == 18 )
{
	return switch( __arg0 )
	{
		// case	106	:	10;
		default		:	1000;
	}
}

// self damage. Buildings are self damage
if( __type == 19 )
{
	return switch( __arg0 )
	{
		case	116	:	0.002;
		case	108	:	0.001;
		default		:	0;
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
		case	115	:	1.0	;
		case	116	:	0.5	;

		
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
		case	101	:	0.30	;
		case	102	:	0.30	;
		case	103	:	0.04	;
		case	104	:	0.24	;
		case	105	:	0.68	;
		case	106	:	0.16	;
		case	107	:	1.00	;
		case	108	:	0.07	;
		case	109	:	-0.08	;
		case	110	: 	0.10	;
		case	111	: 	0.24	;
		case	112	:	0.10	;
		case	113	:	0.20	;
		case	114	:	0.12	;
		case	115	:	0.24	;
		case	116	:	0.20	;	
		
		case	151	:	0.70	;
		case	152	:	0.40 	;
		
		case	201	:	0.06	;
		case	221	:	0.20	;
		case	222	:	0.26	;
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
		case	116	:	1.7	;

		
		case 	201 :	1.0 ;
		case 	221 :	1.0 ;
		case 	222 :	1.5 ;
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
		case	115	:	0.2	;
		case	116	:	0.6	;	

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
		case	103	:	0.4		;
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
		case	115	:	0.5		;
		case	116	:	1.3		;	

		
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
		case	107	:	10.0	;
		case	108	:	0.50	;
		case	109	:	9.00	;
		case	110	:	0.50	;
		case	111	:	12.0	;
		case	112	:	0.50	;
		case	113	:	0.50	;
		case	114	:	0.50	;
		case	115	:	0.50	;
		case	116	:	13.0	;	
		
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
		case	102	:	true;
		case	103	:	true;
		case	108	:	true;
		case	109	:	true;
		case	110	:	true;
		case	112	:	true;
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
		case 2:		__arg1 ? 3.0 : 2.0;
		default:	__arg1 ? 2.5 : 1.5;
	}
}

// getRewardCoef(type:Int) : Float
if( __type == 48 )
{
	return switch( __arg0 )
	{
		case 0:		1;
		case 1:		2;
		case 2:		3;
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
		case 0:		"6:1";
		case 1:		"6:2";
		case 2:		"6:3";
		case 3:		"6:4";
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
		case 0	: 2;
		case 2	: 2;
		default	: 1;
	}

	// mode 1
	return switch( __arg1 )
	{
		case 0	: 2;
		case 2	: 2;
		default	: 1;
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
			case 2	: 1300;
			default	:	0;
		}

		// mode 1
		return switch( __arg1 )
		{
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
			case 0	: 	[1, 300, 1500, 300];
			case 1	:		[2, 200, 1300, 300];
			case 2	: 	[0, 200, 1300, 300];
			default	:	null;
		}

		if( __arg1 == "cover" )
		return switch( __arg2 )
		{
			case 1	: 	[2, 350, 1350, 500];
			case 2	: 	[2, 200, 1200, 500];
			case 11	:	[3, 300, 1300, 500];
			case 21	: 	[2, 300, 1350, 500];
			case 22	: 	[2, 200, 1200, 500];
			default:	null;
		}

		if( __arg1 == "newround" )
		return switch( __arg2 )
		{
			case 0	: 	[1, 450, 850, 200];
			case 1	:	[1, 450, 900, 200];
			case 2	: 	[1, 450, 900, 200];
			default:	null;
		}
	}

	// mode 1
	if( __arg1 == "start" )
	return switch( __arg2 )
	{
		case 0	: 	[2, 550, 1500, 500];
		case 1	:		[3, 712, 1400, 500];
		case 2	: 	[0, 525, 1350, 500];
		default:	null;
	}

	if( __arg1 == "cover" )
	return switch( __arg2 )
	{
		case 1	: 	[3, 780, 1400, 500];
		case 2	: 	[1, 300, 1250, 500];
		case 11	:		[1, 335, 1400, 500];
		case 21	: 	[3, 610, 1400, 500];
		case 22	: 	[2, 450, 1400, 500];
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

// bot troops enemy list
if( __type == -3 || __type == 68 )
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
		case	115	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152	];
		case	116	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152	];

		default   :[ -1 ];
	}
}

if( __type == 81 )
{
	return [
		[-1,	 	 -8,		"-8:101,-7:102:,-6:103,-5:104,-4:105,-3:106,-2:107,-1:108"],
		[100,	 	 -5,		"30:3:10,				60:53:1,				100:109:1"],
		[220,	 	 -3, 		"140:3:10,			180:31:0,				220:151:1"],
		[400,	 	 -2,	 	"280:6:5,				340:3:10,				400:110:1"],
		[700,	 	 -1, 		"500:4:5,				600:3:10,				700:111:1"],
		[1000,	  	0,		"800:53:1,			900:3:10,				1000::32:0"],
		[1400,	  	1, 		"1140‬:3:10,		 1280:54:1,			 1400:112:1"],
		[2000,		2, 		"1600:6:7,			1800:3:12,			2000:113:1"],
		[2900,		3, 		"2300:4:5,			2600:3:12,			2900:153:1"],
		[4000,		4, 		"3250:3:12,			3550:53:1,			4000:114:1"],
		[6000,		5, 		"4600:33:0,			5300:6:7,				6000:154:1"],
		[8400,		5, 		"6800:3:12,			7600:4:7,				8400:115:1"],
		[12000,		5, 		"9600:54:1,			10800:3:12,			12000:116:1"],
		[16000,		5, 		"13300:4:7,			14600:3:12,			16000:152:1"],

		[21000,		2, 		"17600:6:7,			19300:32:12,		21000:117:1"],
		[25000,		3, 		"22500:4:5,			23700:3:12,			25000:118:1"],
		[30000,		4, 		"26500:3:12,		28000:53:1,			30000:119:1"],
		[36000,		5, 		"32000:33:0,		34000:6:7,			36000:156:1"],
		[42000,		5, 		"38000:3:12,		40000:4:7,			42000:120:1"],
		[50000,		5, 		"44500:54:1,		47000:3:12,			50000:121:1"],
		[60000,		5, 		"53500:4:7,			56500:3:12,			60000:122:1"],
	];
}

return 0;