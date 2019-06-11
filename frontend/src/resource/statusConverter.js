// Mixin for database status conversion to text

export default {

  data () {

    return {
      memberStatus:
        [
          "Active", //0
          "Dismissed", //1
          "Relieved from duty", //2
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
          {short: "VVS", long:"Voyenno-Vozdushnye Sily Rossii"} //3
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
          "N/A" //5
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
        ]
    }
  }
}

