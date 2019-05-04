//trace("featureType:" + featureType + " cardType:" + cardType + " cardLevel:" + cardLevel);

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


if( featureType == -3 )
{
	return switch ( cardType )
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

		default     :[ -1 ];
	}
}

// version
if( featureType == -2 )
{
	return 1400.0;
}

// chance
if( featureType == -1 )
{
	return switch ( cardType )
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
		case	110	:	12	;
		case	111	:	18	;
		case	112	:	30	;
		case	113	:	40	;
		case	114	:	40	;
		case	115	:	0	;
		
		case	151	:	8	;
		case	152	:	10	;
		
		default		:	1000;
	}
}

// rarity
if( featureType == 0 )
{
	return switch ( cardType )
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
if( featureType == 1 )
{
	var all = [108,109,151,110,111,152,112,113,153,114,154,115,116,155,117,118,119,156,120,121,122,123,157,124,125,126,127,128,158,129,130,159];
	if( cardType == -1 )
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
		if( c == cardType )
			return index;
		index ++;
	}
	return 0;
}


// elixirSize
if( featureType == 2 )
{
	return switch( cardType )
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
if( featureType == 3 )
{
	return switch ( cardType )
	{
		case	101	:	 1	;
		case	102	:	 1	;
		case	103	:	 6	;
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
if( featureType == 4 )
{
	var ret = switch( cardType )
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
if( featureType == 11 )
{
	var ret = switch ( cardType )
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
if( featureType == 12 )
{
	var ret = switch ( cardType )
	{
		case	101	:	0.50;
		case	102	:	3.00;
		case	103	:	0.30;
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
	return (ret * Math.pow(1.095, cardLevel - 1)) * 1.5;
}

// sizeH
if( featureType == 13 )
{
	var ret = return switch ( cardType )
	{
		case	101	:	15	;
		case	102	:	45  ;
		case	103	:	10	;
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
if( featureType == 14 )
{
	var ret = switch ( cardType )
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
if( featureType == 15 )
{
	var ret = switch( cardType )
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

		
		case 	201 : 	1.5 ;
		case 	221 : 	1.6 ;
		case	222	:	1.9	;
		case	223	:	1.6	;
		
		
		default		:	1.0	;
	}
	return ret * 350;
}

// explosive
if( featureType == 16 )
{
	return switch ( cardType )
	{
		case	107	:	true;
		default		:	false;
	}
}


// bulletSpeed
if( featureType == 21 )
{
	var ret = switch( cardType )
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
if( featureType == 22 )
{
	var ret = switch( cardType )
	{
		case	101	:	0.30	;
		case	102	:	0.30	;
		case	103	:	0.06	;
		case	104	:	0.24	;
		case	105	:	0.68	;
		case	106	:	0.16	;
		case	107	:	0.60	;
		case	108	:	0.07	;
		case	109	:  -0.08	;
		case	110	:  	0.10	;
		case	111	:  	0.24	;
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
	return (ret * Math.pow(1.095, cardLevel - 1));
}

// bulletShootGap
if( featureType == 23 )
{
	var ret = switch( cardType )
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
	return ret * 750 ;
}

// bulletShootDelay
if( featureType == 24 )
{
	var ret = switch( cardType )
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

		
		case	201	:	0.5;
		case	221	:	0.5;
		case	222	:	0.5;
		case	223	:	0.5;
		
		default		:	1.0;
	}
	return ret * 700 ;
}

// bulletRangeMin
if( featureType == 25 )
{
	return 0;
}

// bulletRangeMax
// H = min 1.5 , max 1.8
// M = min 1.0 , max 1.4
// L = min 0.6 , max 0.9
// melee = min 0.1 , max 0.5 
if( featureType == 26 )
{
	var ret =  switch( cardType )
	{
		case	101	:	1.8 ;
		case	102	:	0.9	;
		case	103	:	0.4	;
		case	104	:	0.9	;
		case	105	:	0.5	;
		case	106	:	1.6	;
		case	107	:	0.1	;
		case	108	:	1.4	;
		case	109	:	1.0	;
		case	110	:	0.8	;
		case	111	:	0.9	;
		case	112	:	0.4 ;
		case	113	:	0.4 ;
		case	114	:	0.4	;
		case	115	:	0.9	;

		
		case 	201 : 	1.5 ;
		case 	221 : 	0.5 ;
		case 	222 : 	1.4 ;
		case 	223 : 	0.4 ;
		
		
		default		:	1.0;
	}
	return ret * 300;
}

// bulletDamageArea
//H = min 12 , max ~
//M = min 5.0 , max 10 
//L = min 0.7 , max 1.0
if( featureType == 27 )
{
	var ret =  switch( cardType )
	{
		case	101	:	0.70	;
		case	102	:	0.70	;
		case	103	:	0.70	;
		case	104	:	12.0	;
		case	105	:	0.70	;
		case	106	:	18.0	;
		case	107	:	20.0	;
		case	108	:	0.70	;
		case	109	:	12.0	;
		case	110	:	0.70	;
		case	111	:	12.0	;
		case	112	:	0.70	;
		case	113	:	0.70	;
		case	114	:	0.70	;
		case	115	:	12.0	;

		
		case	151	:	17.0	;
		case	152	:	20.0	;
		
		case 	201 : 	0.70 	;
		case 	221 : 	1.00 	;
		case 	222 : 	0.70 	;
		case	223	:	0.70	;
		
		default 	:	1.00	;
	}
	return ret * 10;
}

// bulletExplodeDelay
if( featureType == 28 )
{
	return switch( cardType )
	{
		case	106	:	0	;
		default		:	0	;
	}
}

// force kill
if( featureType == 29 )
{
	return switch ( cardType )
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


return 0;