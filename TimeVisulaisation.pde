
StringList TimeStamp = new StringList();
StringList fetchTimeStamp = new StringList();

Table writeTable;
Table readTable;
String filePath="";
int sysStatus = 0;
void setup () 
{
	size(500,500);
	textSize(32);
	text("File should be csv also format is h:mm:ss in column one and It could only do for one day", 10, 30, 400,400); 
	create_time_list();
	selectInput("Select a file to process:", "fileSelected");		
}

void draw()
{
	if(sysStatus == 1)
	{
		print("start");
		readTable = loadTable(filePath, "header, csv");	
		for (TableRow  row : readTable.rows()) 
		{    
			int id = row.getInt(0);
    		fetchTimeStamp.append( row.getString(0));

    		//println(name +" has an ID of " + 0);
  		}

		writeTable = new Table();  
		writeTable.addColumn("Time");
		writeTable.addColumn("state");

		for (int i = 0; i < TimeStamp.size(); i++)
		{
			writeTable.addRow();
	  		writeTable.setString(i,"Time", TimeStamp.get(i));
	  		if(fetchTimeStamp.hasValue(TimeStamp.get(i)))
	  		{
	  			writeTable.setInt(i,"state", 0);
	  		}
	  		else
	  		{
	  			writeTable.setInt(i,"state", 1);
	  		}
			/* code */
		}
  		saveTable(writeTable, "data/output.csv");
 		exit(); 
	}
	else if(sysStatus == -1)
	{
		exit(); 
	}
}


void create_time_list()
{
	for (int hours = 0; hours < 24; hours++)
	{
		for (int min = 0; min < 60; min++)
		{
			for (int sec = 0; sec < 60; sec++)
			{	
				String temp = str(hours)+":"+nf(min,2)+":"+nf(sec,2);
				//println(temp);
				TimeStamp.append(temp);
			}		
		}		
	}
}

void fileSelected(File selection) 
{
	if (selection == null) 
	{
    	println("Window was closed or the user hit cancel.");
    	sysStatus = -1;
  	} 
  	else 
  	{
    	println("User selected " + selection.getAbsolutePath());
    	filePath = selection.getAbsolutePath();
    	sysStatus = 1;
  	}
}
