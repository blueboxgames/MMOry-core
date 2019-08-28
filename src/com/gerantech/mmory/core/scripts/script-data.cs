
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
		case	117	:	0	;
		case	118	:	0	;
		case	119	:	0	;

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
		case	117	:	 1	;
		case	118	:  2	;
		case	119	:  1	;
		
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
		case 107 :  3	;
		case 108 :  3	;
		case 109 :  4	;
		case 110 :  2	;
		case 111 :  6	;
		case 112 :  5	;
		case 113 :  3	;
		case 114 :  3	;
		case 115 :  5	;
		case 116 :  5	;	
		case 117 :  4 ;
		case 118 :  3	;
		case 119 :  3 ;


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
		case	117	:  12	;
		case  118 :  1	;
		case	119	:  1	;
	
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
		case	102	:	 2.0	;
		case	103	:	 1.0	;
		case	104	:	 1.0	;
		case	105	:	 1.2	;
		case	106	:	 1.0	;
		case	107	:	 2.5	;
		case	108	:	 1.0	;
		case	109	:	 1.0	;
		case	110	:	 1.0	;
		case	111	:	 1.0	;
		case	112	:	 0.8	;
		case	113	:	 0.8	;
		case	114	:	 1.0	;
		case	115	:	 2.5	;
		case	116	:	 2.0	;	
		case	117	:  1.0	;
		case  118 :  2.0	;
		case	119	:  1.0  ;
		
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
		case	117	: -100;
		case	118	: -100;

		default		:	0;
	}
}

// speed
// H = min 1.6 , max ~    
// M = min 0.8 , max 1.5  
// L = min 0.5 , max 0.7
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
		case	113	:	0.70;
		case	114	:	1.10;
		case	115	:	0.60;
		case	116	:	0.00;
		case	117	: 1.10;
		case	118	: 0.70;
		case	119	: 0.00;

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
		case	113	:	1.40;
		case	114	:	0.80;
		case	115	:	3.50;
		case	116	:	1.80;
		case	117	: 0.15;
		case	118	: 1.40;
		case	119	: 1.40;

		
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
		case	116	:	50	;	
		case	117	: 5.0	;
		case	118	: 35	;
		case	119	: 40	;

		
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
		case	117	: 0.35;
		case	118	: 0.45;
		case	119	: 0.40;


		case	151	:	1.00;

		case	201	:	0.90;
		case	221	:	0.90;
		case	222	:	0.90;
		case	223	:	0.50;
		
		default		:	1.00;
	}
	return ret * 100;
}


// explosive
if( __type == 16 )
{
	return switch( __arg0 )
	{
		case	107	:	true;
		case	118	: true;
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
		case	102	:	false;
		case	118	: false;
		default		:	true;
	}
}


// focus height
if( __type == 18 )
{
	return switch( __arg0 )
	{
		case	101	:	-105;
		case	102	:	-30	;
		case	103	:	-30	;
		case	104	:	-105;
		case	105	:	-30	;
		case	106	:	-30	;
		case	107	:	-30	;
		case	108	:	-105;
		case	109	:	-30	;
		case	110	:	-105;
		case	111	:	-105;
		case	112	:	-30 ;
		case	113	:	-30 ;
		case	114	:	-30	;
		case	115	:	-30	;
		case	116	:	-30	;
		case	117	: -30 ;
		case	118	: -30 ;
		case	119	: -30	;

		case  151 : -30 ;
		case  152 : -105;

		
		case 	201 : -105 	;
		case 	221 :	-30 	;
		case	222	:	-105	;
		case	223	:	-30		;

		default		:	-1;
	}
}


// self damage. Buildings that has self damage
if( __type == 19 )
{
	return switch( __arg0 )
	{
		case	116	:	0.002;
		case	119	: 0.002;

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
		case	117	: 1.3 ;
		case	118	: 1.0 ;
		case	119	: 0.9	;

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


// bulletDamage (Damage/Gap = Damage per second)
// Spells must divide by 3 
if( __type == 22 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.30	;
		case	102	:	0.30	;
		case	103	:	0.057	;
		case	104	:	0.24	;
		case	105	:	0.68	;
		case	106	:	0.16	;
		case	107	:	0.50	;
		case	108	:	0.11  ;
		case	109	:	-0.1	;
		case	110	: 0.171	;
		case	111	: 0.24	;
		case	112	:	0.157	;
		case	113	:	0.3		;
		case	114	:	0.206	;
		case	115	:	0.24	;
		case	116	:	0.10	;	
		case	117	: 0.19	;
		case	118	: 0.60  ;
		case	119	: 0.30  ; 
		
		case	151	:	0.70	;
		case	152	:	0.40 	;
		
		case	201	:	0.073	;
		case	221	:	0.2		;
		case	222	:	0.26	;
		case	223	:	0.25	;
		
		
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
		case	103	:	1.0	;
		case	104	:	1.3	;
		case	105	:	1.7 ;
		case	106	:	1.5 ;
		case	107	:	1.0	;
		case	108	:	1.2	;
		case	109	:	1.2	;
		case	110	:	1.2	;
		case	111	:	1.3	;
		case	112	:	1.1	;
		case	113	:	1.2	;
		case	114	:	1.2	;
		case	115	:	1.3	;
		case	116	:	1.6	;
		case	117	: 1.0 ;
		case	118	: 1.0 ;
		case	119	: 1.5 ;	

		
		case 	201 :	1.2 ;
		case 	221 :	1.0 ;
		case 	222 :	1.5 ;
		case 	223 :	1.1 ;
		
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
		case	117	: 0.7 ;
		case	118	: 0.0 ;
		case	119	: 0.6 ;

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
		case	102	:	1.2		;
		case	103	:	0.4		;
		case	104	:	0.9		;
		case	105	:	0.5		;
		case	106	:	1.6		;
		case	107	:	0.1		;
		case	108	:	1.4		;
		case	109	:	1.0		;
		case	110	:	0.9		;
		case	111	:	0.9		;
		case	112	:	0.4 	;
		case	113	:	0.4 	;
		case	114	:	0.4		;
		case	115	:	0.5		;
		case	116	:	1.6		;	
		case	117	: 0.4		;
		case	118	: 0.1		;
		case	119	: 1.4		;

		case 	201 : 1.5 	;
		case 	221 : 0.5 	;
		case 	222 : 1.4 	;
		case 	223 : 0.4 	;
		
		default		:	1.0;
	}
	return ret * 300;
}


// focusRange
if( __type == 15 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	1.8 ;
		case	102	:	1.2	;
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
		case	117	: 1.0 ;
		case	118	: 1.0 ;
		case	119	: 1.6	;

		
		case 	201 : 1.5 ;
		case 	221 :	1.6 ;
		case	222	:	1.9	;
		case	223	:	1.6	;
		
		
		default		:	1.0	;
	}
	return ret * 350;
}


// bulletDamageArea
//H = min 14 , max ~
//M = min 8.0 , max 13 
//L = min 0.7 , max 4.0
if( __type == 27 )
{
	var ret =  switch( __arg0 )
	{
		case	101	:	0.50	;
		case	102	:	0.50	;
		case	103	:	0.50	;
		case	104	:	11.0	;
		case	105	:	0.50	;
		case	106	:	16.0	;
		case	107	:	14.0	;
		case	108	:	0.50	;
		case	109	:	9.00	;
		case	110	:	0.50	;
		case	111	:	11.0	;
		case	112	:	0.50	;
		case	113	:	0.50	;
		case	114	:	0.50	;
		case	115	:	0.50	;
		case	116	:	16.0	;	
		case	117	: 0.50  ;
		case	118	: 13.0  ;
		case	119	: 0.50  ;
		
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
		case	117	: true;
		case	119	:	true;
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

// challengeBasedTicketCapacity(type:Int):Int
if( __type == 53 )
{
	return switch( __arg0 )
	{
		case 0:		10;
		case 1:		15;
		case 2:		20;
		default:	20;
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
			default	:	0;
		}

		// mode 1
		return switch( __arg1 )
		{
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
			case 0	: 	[1, 300, 1500, 300, false];
			case 1	:		[2, 200, 1300, 300, false];
			case 2	: 	[0, 200, 1300, 300, true];
			default	:	null;
		}

		if( __arg1 == "cover" )
		return switch( __arg2 )
		{
			case 1	: 	[2, 350, 1350, 500, false];
			case 2	: 	[2, 200, 1200, 500, false];
			case 11	:		[3, 300, 1300, 500, false];
			case 21	: 	[2, 300, 1350, 500, false];
			default:	null;
		}

		if( __arg1 == "newround" )
		return switch( __arg2 )
		{
			case 0	: 	[1, 450, 850, 200, false];
			// case 1	:		[1, 450, 900, 200, false];
			// case 2	: 	[1, 450, 900, 200, false];
			default:	null;
		}
	}

	// mode 1
	if( __arg1 == "start" )
	return switch( __arg2 )
	{
		case 0	: 	[2, 550, 1500, 500, false];
		case 1	:		[3, 712, 1400, 500, false];
		case 2	: 	[0, 525, 1350, 500, true];
		default:	null;
	}

	if( __arg1 == "cover" )
	return switch( __arg2 )
	{
		case 1	: 	[3, 780, 1400, 500, false];
		case 2	: 	[1, 300, 1250, 500, false];
		case 11	:		[1, 335, 1400, 500, false];
		case 21	: 	[3, 610, 1400, 500, false];
		default:	null;
	}

	if( __arg1 == "newround" )
	return switch( __arg2 )
	{
		case 0	: [1, 540, 1400, 3000, false];
		// case 1	:	[3, 540, 1500, 3000, false];
		// case 2	: [2, 540, 1500, 3000, false];
		default:	null;
	}
	return null;
}

//elixirSpeedRatio(mode:Int, side:Int, battleWins:Int) : Float
if( __type == 69 )
{
	// mode 0
	if( __arg0 == 0 )
	return switch( __arg2 )
	{
		case 0	: (__arg1 == 0 ? 1.5 : 0.00);
		case 1	: (__arg1 == 0 ? 1.5 : 0.35);
		case 2	: (__arg1 == 0 ? 1.5 : 0.40);
		case 3	: (__arg1 == 0 ? 1.2 : 0.70);

		default	:	1;
	}

	// mode 1
	return switch( __arg2 )
	{
		case 0	: (__arg1 == 0 ? 1.5 : 0.20);
		case 1	: (__arg1 == 0 ? 1.5 : 0.35);
		case 2	: (__arg1 == 0 ? 1.5 : 0.50);
		case 3	: (__arg1 == 0 ? 1.2 : 0.70);

		default	:	1;
	}
}

// bot troops enemy list
if( __type == -3 || __type == 68 )
{
	return switch( __arg0 )
	{
		case	101	:[	105 ,  113 , 103 , 112 , 106 , 151 , 110 , 108 , 102 , 101 , 107 , 111 , 152 , 104 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	102	:[	103 ,  112 , 101 , 108 , 110 , 105 , 106 , 113 , 111 , 102 , 107 , 104 , 151 , 152 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	103	:[	151 ,  152 , 106 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	104	:[	101 ,  105 , 108 , 113 , 107 , 106 , 104 , 102 , 112 , 151 , 152 , 111 , 103 , 110 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	105	:[	103 ,  110 , 112 , 101 , 106 , 108 , 113 , 102 , 105 , 111 , 104 , 107 , 151 , 152 , 109 , 114 , 115 , 116 , 117 , 118 , 119 	];
		case	106	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	107	:[	103 ,  108 , 102 , 104 , 101 , 105 , 113 , 151 , 152 , 106 , 107 , 111 , 110 , 112 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	108	:[	105 ,  113 , 101 , 102 , 106 , 107 , 108 , 112 , 111 , 103 , 104 , 151 , 152 , 110 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	110	:[	152 ,  106 , 151 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	111	:[	101 ,  105 , 108 , 113 , 107 , 106 , 104 , 102 , 112 , 151 , 152 , 111 , 103 , 110 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	112	:[	151 ,  152 , 106 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	113	:[	103 ,  110 , 101 , 108 , 112 , 105 , 106 , 113 , 111 , 102 , 107 , 104 , 151 , 152 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	114	:[	151 ,  152 , 106 , 104 , 107 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 102 , 113 , 109 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	115	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	116	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	117	:[	152 ,  104 , 101 , 111 , 110 , 108 , 112 , 105 , 102 , 113 , 109 , 151 , 106 , 107 , 103 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	118	:[	104 ,  101 , 111 , 110 , 108 , 152 , 112 , 105 , 102 , 113 , 109 , 151 , 106 , 107 , 103 , 114 , 115 , 116 , 117 , 118 , 119	];
		case	119	:[	105 ,  101 , 108 , 113 , 102 , 104 , 111 , 106 , 107 , 103 , 110 , 112 , 109 , 151 , 152 , 114 , 115 , 116 , 117 , 118 , 119	];


		default   :[ -1 ];
	}
}

if( __type == 81 )
{
	return [
		[-1,	 	  0,			"-8:101,-7:102:,-6:103,-5:104,-4:105,-3:106,-2:119,-1:108"],
		[100,	 	  0,			"30:53:10,			65:31:0,				100:118:1"],
		[220,	 	  0, 			"140:6:5,				180:3:10,				220:112:1"],
		[400,	 	  0,	 		"280:6:5,				340:3:10,				400:152:1"],
		[700,	 	  0, 			"500:4:10,			600:3:20,				700:111:0"],
		[1000,	  0,			"800:53:1,			900:3:25,				1000:107:1"],
		[1400,	  0, 			"1140‬:3:30,		 1280:54:1,			 1400:109:1"],
		[2000,	  0, 			"1600:6:10,			1800:3:35,			2000:114:1"],
		[2900,	  0, 			"2300:4:10,			2600:3:40,			2900:151:1"],
		[4000,	  0, 			"3250:3:45,			3550:53:1,			4000:115:1"],
		[6000,	  0, 			"4600:3:50,			5300:6:10,			6000:110:1"],
		[8400,	  0, 			"6800:3:60,			7600:4:10,			8400:117:1"],
		[12000,	  0,			"9600:54:1,			10800:3:70,			12000:113:1"],
		[16000,	  0, 			"13300:4:15,		14600:3:80,			16000:153:1"],

		[21000,		0, 		 "17600:6:15,			19300:3:90,			21000:154:1"],
		[25000,		0, 		 "22500:4:15,			23700:3:100,		25000:124:1"],
		[30000,		0, 		 "26500:3:200,		28000:53:1,			30000:120:1"],
		[36000,		0, 		 "32000:3:300,		34000:6:15,			36000:121:1"],
		[42000,		0, 	   "38000:33:0,			40000:4:20,			42000:122:1"],
		[50000,		0, 		 "44500:54:1,			47000:3:400,		50000:123:1"],
		[60000,		0, 		 "53500:4:20,			56500:3:500,		60000:116:1"],
		[60000,		0, 		 "63500:4:20,			66500:3:500,		70000:126:1"],
		[60000,		0, 		 "73500:4:20,			76500:3:500,		80000:127:1"],
		[60000,		0, 		 "83500:4:20,			86500:3:500,		90000:128:1"],
		[60000,		0, 		 "93500:4:20,			96500:3:500,		100000:129:1"],
		[60000,		0, 		 "101000:4:20,		102000:3:500,		103000:130:1"],
		[60000,		0, 		 "104000:4:20,		105000:3:500,		106000:156:1"],
		[60000,		0, 		 "107000:4:20,		108000:3:500,		109000:157:1"],
		[60000,		0, 		 "110000:4:20,		120000:3:500,		130000:158:1"],
		[60000,		0, 		 "140000:4:20,		150000:3:500,		160000:159:1"],
		[60000,		0, 		 "170000:4:20,		180000:3:500,		190000:160:1"],
	];
}

return 0;