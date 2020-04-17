require_install = function(package_name) 
{
   if (!package_name %in% installed.packages()) 
   {
      install.packages(package_name)
   }
}