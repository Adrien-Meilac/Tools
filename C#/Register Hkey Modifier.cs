using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Win32;

class Program
{
	static void Main(string[] args)
	{
		RegistryKey key = Registry.CurrentUser.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", true);
		if(key != null)
		{
			key.SetValue("HideFileExt", 0,RegistryValueKind.DWord);
			key.SetValue("NavPaneExpandToCurrentFolder", 0,RegistryValueKind.DWord);
			key.Flush();
			key.Close();
		}

		string RCodeDirectory = @"%userprofile%\R\R-3.4.0\bin\x64";
		RCodeDirectory = Environment.ExpandEnvironmentVariables(RCodeDirectory);
		Console.WriteLine("Le dossier contenant Rscript est : " + RCodeDirectory);
		string response = "";
		while (response != "y" && response != "n")
		{
			Console.WriteLine("Souhaitez-vous le changer ? (y/n)");
			response = Console.ReadLine();
		}
		if (response == "y")
		{
			Console.WriteLine("Entrez le nouveau chemin à mettre :");
			RCodeDirectory = Console.ReadLine();
		}
		key = Registry.CurrentUser.OpenSubKey(@"Control Panel\International", false);
		if(key != null)
		{
			char list_delimitor = key.GetValue("sList").ToString()[0];
			char number_delimitor = key.GetValue("sDecimal").ToString()[0];
			key.Close();
			key = Registry.CurrentUser.OpenSubKey(@"Environment", true);	
			//	key = Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\Session Manager\Environment", true);
			if (key != null)
			{
				string pathtext = key.GetValue("Path").ToString();
				string[] path = pathtext.Split(list_delimitor);
				bool isAlreadyAddedToPath = false;
				foreach(string s in path)
				{
					if(s == RCodeDirectory)
					{
						isAlreadyAddedToPath = true;
						break;
					}
				}
				if(isAlreadyAddedToPath)
				{
					Console.WriteLine("La variable d'environement correspondante à R a déjà été ajoutée");
				}
				else
				{
					Console.WriteLine("Ajout de la valeur dans le chemin PATH");
					key.SetValue("PATH", key.GetValue("PATH") + list_delimitor.ToString() + RCodeDirectory, RegistryValueKind.ExpandString);
				}
				key.Flush();
				key.Close();
			}
		}
		Console.WriteLine("Press any key to continue");
		Console.ReadLine();
	}
}

