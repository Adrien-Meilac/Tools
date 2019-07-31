t0 = Sys.time() # Setting the initial time
cat(paste("Lauch script at : ", t0, "\n"))

DeltaTimeFromBeginning = function(print = TRUE)
{
   t1 = Sys.time() # Setting the initial time
   delta = t1 - t0
   units(delta) = "secs"
   if(print)
   {
      cat(paste("Current time :", t1, "(", delta , "seconds)\n"))
   }
}