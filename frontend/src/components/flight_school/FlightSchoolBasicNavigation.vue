<template>
    <div class="flightSchool">
      <div class="text-align-center">
      <h1>An Introduction to Navigation</h1>
      </div>
        <div class="text-align-justify">
          <p>This walk-through from 'Grey' shows you how to get to somewhere using the instruments and a little maths, without magnetic deviation (see the advanced navigation). You will also learn to use the IL-2 Cliffs of Dover map tool, found by following this link.</p>
          <img src="../../assets/images/flight_school_images/general/basic_nav01a.jpg" style="width:43%;float:left; border-radius:35px;">
          <div style="margin-left: 44%;margin-right: 4%">
          <span class="headingBigger">Step 1</span>
            <p>Let's plot your course, you want to go from the airfield at Merville Calonne to St-Pol-Sur-Ternoise. I have marked these on the map. In total it's approx. 35km in an overall South-Westerly direction. In this lesson we will rely on ground clues to navigate our way to the target. </p>
            <p>Take off from the airfield and point your nose in a SW direction. </p>
            <p>Once you get onto your desired heading, level off and look out for interesting sights on the ground. We will come across one large town just off your left wing; Bruay La Buissere. Keep this in mind to do adjustments left or right during the flight so that you come across your target in front of you when you arrive.</p>
          </div>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <img src="../../assets/images/flight_school_images/general/basic_nav02.jpg" style="width:30%;float:right;border-radius:35px;margin-right:15%">
          <div style="margin-right: 50%">
            <span class="headingBigger">Step 2</span>
            <p>South-West on the compass translates to 225°. Use a ruler and point it over to the other side you'll notice that you have your reciprocal heading, your bearing back to the home location, in this case 45°.</p>
            <p>In this case the actual heading is 219°, but an offset of 5° is not too bad, especially when you are flying using ground references to navigate.</p>
            <p>Once you have got onto the desired heading, start a stop-watch or take note of the exact time. At about half way you will notice the large town we talked about erlier, just off your left wing. If you see that the town is further away, is below you or is on your right, your heading may be off by a few degrees. Make adjustments left or right to correct your heading.</p>
          </div>
          <br><br><br><br><br><br>
          <img src="../../assets/images/flight_school_images/general/basic_nav04.jpg" style="width:45%;float:left;border-radius:35px;">
          <div style="margin-left: 47%;margin-right: 4%">
            <span class="headingBigger">Step 3</span>
            <p>Mouse over your cockpit compass to get a detailed heading.</p>
            <p>Keep to roughly the same speed throughout your flight and as soon as you get in to contact with the target, or when you arrive, stop the watch and calculate the amount of time it took you to get there. In this case it should be roughly 8 minutes, at a speed of 255 km/h.</p>
            <p>Make sure you don't overshoot your target, especially if it is hiding right under your nose so you can't see it. It is always a good idea to offset your course when you near the target so you will be able to see it and if not, search about for it.</p>
          </div>
          <br><br><br><br><br><br>
          <img src="../../assets/images/flight_school_images/general/basic_nav01b.jpg" style="width:43%;float:right;border-radius:35px;margin-right:5%">
          <div style="margin-right: 50%">
            <span class="headingBigger">Step 4</span>
            <p>To return, simply head back in the opposite direction. That would be approx. 45°. </p>
            <p>Now this is important, you must keep your speed the same throughout the return journey. That way you won't reach your airfield quicker than you expect and probably will overshoot it. After 6 minutes you will start looking around for your airfield, remember the flight took 8 minutes when flying out, so after 6 minutes you should be within visual range of your home field.</p>
            <p>If by any chance you had to make adjustments on your way in, calculate an average. This is not rocket science so don't break your head over it, just use the ruler over your compass rose and do an estimate.</p>
            <p>The image shown here on the right is a screenshot of a brilliant tool you can use to plan your flights. </p>
          </div>
          <br><br><br><br><br><br>
          </div>
      <div class="text-align-center">
      <h2>Print-Outs</h2>
        <p>Here are a couple of sample roses but you can find other examples on the internet if you want to look for one you like. To open a larger version of this image, right click and select View Image. Print out, laminate and keep beside your virtual cockpit. Happy navigating!</p>
        <img src="../../assets/images/flight_school_images/general/basic_nav05.jpg" style="width:60%;border-radius:35px;">
        <p>This is a large-scale map of the Channel Map for IL-2 Sturmovik: Cliffs of Dover 'Blitz'.</p>
        <img src="../../assets/images/flight_school_images/general/full-map.jpg" style="width:80%;border-radius:35px;">
      </div>
    </div>
</template>

<script>
  import DivLinkButton from "../basic_comp/DivLinkButton";
  export default {
    // Same name as file-name. Change the name when altering the file-name
    name: 'FlightSchoolBasicNavigation',
    components: {DivLinkButton},
    // Data needed in component, probably not necessary
    data () {
      return {
        // Data goes in here...

      }
    },
    // Methods needed in component, probably not necessary
    methods: {

      navigate_to: function (link) {

        location.replace(link);
      }
    }
  }

</script>

<style scoped>


</style>
