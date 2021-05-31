// Mixin for database status conversion to text

export default {

  data () {

    return {
      memberStatus:
        [
          "Active", //0
          "Dismissed", //1
          "On leave", //2
          "Passed away" //3
        ],

      simPlatform:
        [
          "IL-2 Cliffs of Dover", //0
          "IL-2 Battle of Moscow", //1
          "IL-2 Battle of Stalingrad", //2
          "IL-2 Battle of Kuban", //3
          "Rise of flight" //4
        ],

      campaignStatus:
        [
          "In preparation", //0
          "Ongoing", //1
          "Finished" //2
        ],

      missionStatus:
        [
          "Briefing", //0
          "Debriefing", //1
          "Closed" //2
        ],

      pilotStatus:
        [
          "OK", //0
          "Wounded", //1
          "POW", //2
          "KIA", //3
        ],

      assetStatus:
        [
          "OK", //0
          "Damaged", //1
          "Lost" //2
        ],

      factionStatus:
        [
          {short: "", long: ""}, //0
          {short: "LW", long:"Luftwaffe"}, //1
          {short: "RAF", long:"Royal Air Force"}, //2
          {short: "VVS", long:"Voyenno-vozdushnyye sily RKKA"}, //3
          {short: "RA", long: "Regia Aeronautica"} //4
        ],

      flightStatus:
        [
          "A Flt", //0
          "B Flt", //1
          "N/A" //2
        ],

      sectionPosStatus:
        [
          "Squadron Commander", //0
          "Section Commander", //1
          "2", //2
          "3", //3
          "4", //4
          "5", //5
          "6", //6
          "N/A" //7
        ],

      sectionStatus:
        [
          "Black Sect", //0
          "Red Sect", //1
          "Yellow Sect", //2
          "Green Sect", //3
          "Blue Sect", //4
          "Gold Sect", //5
          "White Sect", //6
          "Pink Sect", //7
          "N/A", //8
        ],

      claimRAFenemyStatus:
        [
          "Destroyed", //0
          "Probable", //1
          "Damaged" //2
        ],

      swarmStatus:
        [
          "1.Schwarm", //0
          "2.Schwarm", //1
          "3.Schwarm", //2
          "4.Schwarm", //3
          "N/A", //5
        ],

      swarmPosStatus:
        [
          "Staffelführer", //0
          "Schwarmführer", //1
          "Rottenführer", //2
          "Katschmarek", //3
          "N/A" //4
        ],

      claimLWTypeOfDestruction:
        [
          "Light smoke", //0
          "Dark smoke", //1
          "Flames", //2
          "Parts broken away", //3
          "Explosion", //4
          "Forced crash landing", //5
          "Set alight on ground", //6
        ],

      claimLWTypeOfImpact:
        [
          "Not observed", //0
          "Steep angle with crash fire", //1
          "Shallow angle with crash fire", //2
          "Steep angle with dust cloud", //3
          "Shallow angle with dust cloud", //4
          "Splashdown" //5
        ],

      claimLWFateOfCrew:
        [
          "Not observed", //0
          "Parachuted", //1
          "Dead" //2
        ],

      sezioneStatus:
        [
          "1.Sezione", //0
          "2.Sezione", //1
          "3.Sezione", //2
          "4.Sezione", //3
          "N/A", //5
        ],

      sezionePosStatus:
        [
          "Capo squadriglia", //0
          "Capo sezione", //1
          "Spalla", //2
          "Gregario", //3
          "N/A" //4
        ],

      deplUnitTypeStatus:
      [
        {allies: "Fighter", axis: "Jagdgeschwader"}, //0
        {allies: "Bomber", axis: "Sturzkampf-, Kampfgeschwader"}, //1
        {allies: "Ground Attack", axis: "Schlachtgeschwader"}, //2
        {allies: "Heavy Fighter", axis: "Zerstoerergeschwader"},//3
        {allies: "Transport", axis: "Luftlandegeschwader"}, //4
        {allies: "Recon", axis: "Aufklaerungsgeschwader"} //5
      ],

      numberEnemyACStatus:
      [
        "NIL", //0
        "less than 3", //1
        "less than 10", //2
        "less than 20", //3
        "20+", //4
        "30+", //5
        "40+", //6
        "50+", //7
        "60+", //8
        "100+" //9
      ],

      lw_images: { //images for the Luftwaffe character portraits
        background: [1, 2, 3, 4, 5, 6, 7],
        ears: [1, 2, 3, 4, 5, 6, 7],
        eyes: [1, 2, 3, 4, 5, 6],
        hair: [1, 2, 3, 4, 5, 6, 7],
        head: [1, 2, 3, 4, 5, 6, 7],
        mouth: [1, 2, 3, 4, 5, 6, 7],
        nose: [1, 2, 3, 4, 5, 6, 7],
      },

      raf_images: { //images for the Luftwaffe character portraits
        background: [1, 2, 3, 4, 5, 6,],
        ears: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
        eyes: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
        hair: [1, 2, 3, 4, 6, 7, 8, 9, 10, 11],
        head: [1, 2, 3, 4, 5, 6, 7, 8],
        mouth: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
        nose: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      },

      usaaf_images: { //images for the Luftwaffe character portraits
        background: [3, 5, 6],
        ears: [1, 2, 3, 4, 5, 6],
        eyes: [1, 2, 3, 4, 5, 6],
        hair: [1, 2, 3, 4, 5, 6],
        head: [1, 2, 3, 4, 5, 6],
        mouth: [1, 2, 3, 4, 5, 6],
        nose: [1, 2, 3, 4, 5, 6],
      },

      vvs_images: { //images for the Luftwaffe character portraits
        background: [1, 5],
        ears: [4, 6, 8],
        eyes: [1, 2, 3, 6, 7, 8, 11, 12],
        hair: [1, 2, 3, 4, 5, 6, 9],
        head: [1, 2, 3, 4, 5, 6, 7, 8],
        mouth: [1, 2, 5, 8, 9, 10, 11, 12, 14, 15, 16],
        nose: [1, 3, 7, 10],
      },

      ra_images: { //images for the Luftwaffe character portraits
        background: [1, 2, 3, 4, 5, 6, 7],
        ears: [1, 2, 3, 4, 5, 6, 7],
        eyes: [1, 2, 3, 4, 5, 6],
        hair: [1, 2, 3, 4, 5, 6, 7],
        head: [1, 2],
        mouth: [1, 2, 3, 4, 5, 6, 7],
        nose: [1, 2, 3, 4, 5, 6, 7],
      },

    }
  }
}

