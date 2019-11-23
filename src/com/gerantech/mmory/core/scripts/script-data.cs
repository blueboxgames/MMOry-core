
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
		case	117	:	 9	;
		case  	118 :	 1	;
		case	119	:	 1	;
	
		case	151	:	 1	;
		case	152	:	 1	;
		case	201	:	 1	;
		case	202	:	 1	;
		
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
		case	202	:	0.00;
		case	221	:	0;
		case	222	:	0;
		case	223	:	1.30;
		
		
		default		:	0.00;
	}
	return ret * 0.085 * 1;
}

// health
// H = min 2.0 , max ~    
// M = min 1 , max 1.9  
// L = min 0.1 , max 0.8
if( __type == 12 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	0.50;
		case	102	:	2.50;
		case	103	:	0.15;
		case	104	:	1.00;
		case	105	:	1.40;
		case	106	:	0.50;
		case	107	:	0.50;
		case	108	:	0.80;
		case	109	:	0.30;
		case	110	:	0.30;
		case	111	:	1.00;
		case	112	:	0.70;
		case	113	:	1.40;
		case	114	:	0.80;
		case	115	:	3.00;
		case	116	:	1.90;
		case	117	: 0.15;
		case	118	: 1.40;
		case	119	: 1.50;

		case	201	:	5.00;
		case	202	:	8.00;
		case	221	:	6.00;
		case	222	:	2.00;
		case	223	:	2.50;
		
		
		default		:	1.00;
	}
	return (ret * Math.pow(1.095, __arg1 - 1)) * 1.5;
}

// sizeH
if( __type == 13 )
{
	return switch( __arg0 )
	{
		case	101	:	30	;
		case	102	:	45  ;
		case	103	:	30	;
		case	104	:	30	;
		case	105	:	40	;
		case	106	:	30	;
		case	107	:	30	;
		case	108	:	30	;
		case	109	:	40	;
		case	110	:	20	;
		case	111	:	25	;
		case	112	:	25	;
		case	113	:	20	;
		case	114	:	30	;
		case	115	:	25	;
		case	116	:	60	;	
		case	117	:	20	;
		case	118	:	35	;
		case	119	:	40	;

		
		case	201	:	40	;
		case	202	:	45	;
		case	221	:	30	;
		case	222	:	40	;
		case	223	:	25	;
		
		default		:	30	;
	}
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
		case	202	:	1.00;
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
		// case	102	:	false;
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
	var coef = switch( __arg0 )
	{
		case	116	:	35; 	// unit life time
		case	119	: 30;		// unit life time

		default		:	0;
	}
	if( coef == 0 )
		return 0;
	return __arg1 / (1000 * coef);
}


// bulletSpeed
if( __type == 21 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	3.0	;
		case	102	:	1.0	;
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
		case	119	: 1.6	;

		case	151	:	1.2 ;
		case	152	:	0.8	;
		
		case	201	:	1.5	;
		case	202	:	0.0	;
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
		case	102	:	0.25	;
		case	103	:	0.057	;
		case	104	:	0.20	;
		case	105	:	0.68	;
		case	106	:	0.16	;
		case	107	:	0.50	;
		case	108	:	0.09	;
		case	109	:	-0.1	;
		case	110	:	0.17	;
		case	111	:	0.24	;
		case	112	:	0.15	;
		case	113	:	0.3		;
		case	114	:	0.10	;
		case	115	:	0.24	;
		case	116	:	0.16	;	
		case	117	:	0.14	;
		case	118	:	0.60	;
		case	119	:	0.20	; 
		
		case	151	:	0.70	;
		case	152	:	0.40 	;
		
		case	201	:	0.073	;
		case	202	:	0.00	;
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
		case	103	:	0.8	;
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
		case	117	: 2.0 ;
		case	118	: 1.0 ;
		case	119	: 1.5 ;	

		
		case 	201 :	1.2 ;
		case	202	:	100	;
		case 	221 :	1.0 ;
		case 	222 :	1.5 ;
		case 	223 :	1.1 ;
		
		default		:	1.0 ;
	}
	return 	ret * 750 ;
}


// // bulletShootDelay
// if( __type == 24 )
// {
// 	var ret = switch( __arg0 )
// 	{
// 		case	101	:	0.0	;
// 		case	102	:	0.7	;
// 		case	103	:	0.7	;
// 		case	104	:	0.5	;
// 		case	105	:	0.0	;
// 		case	106	:	0.5	;
// 		case	107	:	0.0	;
// 		case	108	:	0.0	;
// 		case	109	:	0.5	;
// 		case	110	:	0.7	;
// 		case	111	:	0.5	;
// 		case	112	:	0.4 ;
// 		case	113	:	0.4 ;
// 		case	114	:	0.7	;
// 		case	115	:	0.2	;
// 		case	116	:	0.6	;	
// 		case	117	: 0.7 ;
// 		case	118	: 0.0 ;
// 		case	119	: 0.6 ;

// 		case	201	:	0.5	;
// 		case	221	:	0.5	;
// 		case	222	:	0.5	;
// 		case	223	:	0.5	;
		
// 		default		:	1.0;
// 	}
// 	return ret * 700 ;
// }

// bulletShootDelay
if( __type == 24 )
{
	var ret = switch( __arg0 )
	{		
		default		:	0;
	}
	return ret;
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
		case	103	:	0.2		;
		case	104	:	0.9		;
		case	105	:	0.4		;
		case	106	:	1.6		;
		case	107	:	0.3		;
		case	108	:	1.3		;
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
		case	119	: 1.6		;

		case 	201 : 1.5 	;
		case	202	:	0.0 	;
		case 	221 : 0.5 	;
		case 	222 : 1.5 	;
		case 	223 : 0.4 	;
		
		default		:	1.0;
	}
	return ret * 260;
}


// focusRange
if( __type == 15 )
{
	var ret = switch( __arg0 )
	{
		case	101	:	1.8 ;
		case	102	:	1.2	;
		case	103	:	0.6	;
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
		case	202	:	0.0	;
		case 	221 :	1.6 ;
		case	222	:	1.9	;
		case	223	:	1.6	;
		
		
		default		:	1.0	;
	}
	return ret * 260;
}


// bulletDamageArea
//H = min 14 , max ~
//M = min 8.0 , max 13 
//L = min 0.7 , max 4.0
if( __type == 27 )
{
	var ret = switch( __arg0 )
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
		case	202	:	0.00	;
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
		case 0:		1;
		case 1:		0;
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

// getRunRequiements(mode:Int):IntIntMap
if( __type == 52 )
{
	return switch( __arg0 )
	{
		case 0:		"6:2";
		case 1:		"6:1";
		case 2:		"6:3";
		case 3:		"6:4";
		default:	"6:0";
	}
}

// challengeBasedTicketReward(type:Int):Int
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

//numtutorBattles(playerId:Int) : Int
if( __type == 61 )
{
	return __arg0 % 2 == 0 ? 4 : 2;
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

// bot prefered unit coefficents
// [position, damage, health, targetType, speed]
if( __type == 67 )
{
	return [1.0, 1.0, 1.0, 1.0, 1.0];
}



// bot troops enemy list
if( __type == 68 || __type == -3 )
{
	return switch( __arg0 )
	{
		case	101	:[	105 ,  113 , 103 , 112 , 106 , 151 , 110 , 108 , 101 , 111 , 152 , 104 , 109 , 107 , 102 , 117 	];
		case	102	:[	103 ,  112 , 101 , 108 , 110 , 105 , 106 , 113 , 111 , 104 , 151 , 152 , 109 , 107 , 102 , 117	];
		case	103	:[	151 ,  152 , 106 , 104 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 113 , 109 , 107 , 102 , 117	];
		case	104	:[	101 ,  105 , 108 , 113 , 106 , 104 , 112 , 151 , 152 , 111 , 103 , 110 , 109 , 107 , 102 , 117	];
		case	105	:[	103 ,  110 , 112 , 101 , 106 , 108 , 113 , 105 , 111 , 104 , 151 , 152 , 109 , 107 , 102 , 117 	];
		case	106	:[	105 ,  101 , 108 , 113 , 104 , 111 , 106 , 103 , 110 , 112 , 109 , 151 , 152 , 107 , 102 , 117	];
		case	107	:[	105 ,  101 , 113 , 108 , 151 , 152 , 106 , 111 , 110 , 112 , 103 , 104 , 109 , 107 , 102 , 117	];
		case	108	:[	105 ,  113 , 101 , 106 , 108 , 112 , 111 , 103 , 104 , 151 , 152 , 110 , 109 , 107 , 102 , 117	];
		case	110	:[	152 ,  106 , 151 , 104 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 113 , 109 , 107 , 102 , 117	];
		case	111	:[	101 ,  105 , 108 , 113 , 106 , 104 , 112 , 151 , 152 , 111 , 103 , 110 , 109 , 107 , 102 , 117	];
		case	112	:[	151 ,  152 , 106 , 104 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 113 , 109 , 107 , 102 , 117	];
		case	113	:[	103 ,  110 , 101 , 108 , 112 , 105 , 106 , 113 , 111 , 104 , 151 , 152 , 109 , 107 , 102 , 117	];
		case	114	:[	151 ,  152 , 106 , 104 , 101 , 111 , 103 , 110 , 112 , 108 , 105 , 113 , 109 , 107 , 102 , 117	];
		case	115	:[	105 ,  101 , 108 , 113 , 104 , 111 , 106 , 103 , 110 , 112 , 109 , 151 , 152 , 107 , 102 , 117	];
		case	116	:[	102 ,  107 , 105 , 101 , 108 , 113 , 104 , 111 , 106 , 103 , 110 , 112 , 109 , 151 , 152 , 117	];
		case	117	:[	104 ,  152 , 108 , 101 , 110 , 111 , 102 , 106 , 103 , 113 , 112 , 109 , 151 , 107 , 105 , 117	];
		case	118	:[	108 ,  101 , 110 , 111 , 104 , 152 , 102 , 106 , 103 , 113 , 112 , 109 , 151 , 107 , 105 , 117	];

		default   :[ -1 ];
	}
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
		case 0	: (__arg1 == 0 ? 1.5 : 0.65);
		case 1	: (__arg1 == 0 ? 1.5 : 0.70);
		case 2	: (__arg1 == 0 ? 1.5 : 0.85);
		case 3	: (__arg1 == 0 ? 1.2 : 0.90);

		default	:	1;
	}
}

if( __type == 81 )
{
	return [
		[-1,	 	  0,			"-8:101,-7:102:,-6:103,-5:104,-4:105,-3:106,-2:107,-1:108"],
		[35,	 	  0,			"8:53:10,						20:31:0,																										35:152:1"],
		[100,	 	  0, 			"55:6:5,						75:3:10,																										100:112:1"],
		[300,	 	  0,	 		"160:6:5,						225:32:0,																										300:119:1"],
		[525,	 	  0, 			"375:4:10,					450:53:1,																										525:111:1"],
		[825,	  	0,			"600:4:10,					675:3:25,						750:53:1,																825:118:1"],
		[1125,	  0, 			"900:3:30,		  		975:54:1,			 		 	1050:3:30,						 									1125:116:1"],
		[1425,	  0, 			"1200:6:10,					1275:3:35,					1350:6:10, 															1425:114:1"],
		[1950,	  0, 			"1500:4:10,					1650:3:40,					1800:4:10, 															1950:151:1"],
		[2700,	  0, 			"2100:3:45,					2250:53:1,					2400:3:45,					2550:53:1,					2700:109:1"],
		[3450,	  0, 			"2850:3:50,					3000:6:10,					3150:3:50,					3300:6:10,					3450:110:1"],
		[4200,	  0, 			"3600:3:60,					3750:4:10,					3900:3:60,					4050:4:10,					4200:117:1"],
		[4950,	  0,			"4350:54:1,					4500:3:70,					4650:54:1,					4800:3:70,					4950:115:1"],
		[5700,	  0, 			"5100:4:15,					5250:3:80,					5400:4:15,					5550:3:80,					5700:113:1"],
		[6750,		0, 		 	"5850:6:15,					6000:3:90,					6225:6:15,					6450:3:90,					6750:154:1"],
		[8250,		0, 		 	"7125:4:15,					7500:3:100,					7725:4:15,					7950:3:100,					8250:124:1"],
		[9750,		0, 		 	"8625:3:200,				9000:53:1,					9225:3:200,					9450:53:1,					9750:120:1"],
		[11250,		0, 		 	"10125:3:300,				10500:6:15,					10725:6:15,					10950:6:15,					11250:121:1"],
		[12750,		0, 	   	"11625:33:0,				12000:4:20,					12225:4:20,					12450:4:20,					12750:122:1"],
		[14250,		0, 		 	"13125:54:1,				13500:3:400,				13725:54:1,					13950:3:400,				14250:123:1"],
		[17250,		0, 		 	"14625:4:20,				15000:3:500,				15750:4:20,					16500:3:500,				17250:153:1"],
		[21000,		0, 		 	"18000:4:20,				18750:3:500,				19500:4:20,					20250:3:500,				21000:126:1"],
	];
}

return 0;