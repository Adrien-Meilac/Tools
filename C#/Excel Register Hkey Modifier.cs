using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Win32;

class Program
{
	static void Main(string[] args)
	{
		// Changement de clé pour la version 14.0 d'Excel :
		RegistryKey key = Registry.CurrentUser.OpenSubKey(@"Software\Microsoft\Office\14.0\Excel\options", true);
		if(key != null)
		{
			key.SetValue("DefSheets", 1, RegistryValueKind.DWord); // Change le nombre de feuille dans un nouveau document
			key.SetValue("DeveloperTools", 1, RegistryValueKind.DWord);	// Active l'onglet d'outils pour les developpeurs
			key.SetValue("Options", 327, RegistryValueKind.DWord); // 327 = Formule en R1C1 et 343 = Formule en A1
			key.SetValue("controlcharacters", 1, RegistryValueKind.DWord); // Visualisation des caractères de controle
			key.Flush();
			key.Close();
		}

		Console.WriteLine("Press any key to continue");
		Console.ReadLine();
	}
}

