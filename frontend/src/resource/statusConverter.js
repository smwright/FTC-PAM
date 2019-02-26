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
          {short: "RAF", long:"Royal Air Force"} //2
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
        ]
    }
  }
}

