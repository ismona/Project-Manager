const monthNames = ["0", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var monthViewsArray = [];   //pole pre ulozenie dynamicky vytvorenych Views


function createMonthViews()
{
    var tempDate;
    var currentMonth = 13;
    var currentYear = 9999;
    var currentArrayIndex = 0;

    var component = Qt.createComponent("MonthRow.qml");

    for(var i=0; i<allProjectsListModel.count; i++) //prechadza vsetky nacitane projekty
    {
        tempDate = new Date(allProjectsListModel.get(i).todayDate); //ziskaj datumovy datovy typ aktualneho projektu (projektu v aktualnej iteracii cyklu)

        if(tempDate.getFullYear() < currentYear)    //aktualny projekt ma vyssi rok ako doterajsie
        {
            currentYear = tempDate.getFullYear();
            currentMonth = 13;   //donuti vytvorit novy view
        }

        if(tempDate.getMonth()+1 < currentMonth)    //aktualny projekt ma vyssi mesiac ako doterajsie -> vytvor novy view
        {
            currentMonth = tempDate.getMonth()+1;   //getMonth() vracia 0-11
            //console.log("vytvaram novy MonthRow.qml pre " + currentMonth + "/" + currentYear);

            monthViewsArray.push(
                {
                    year: currentYear,
                    month: monthNames[currentMonth],
                    object: component.createObject(projectsArea)    //dynamicke vytvorenie objektu, projectsArea je parent, Item z ProjectList.qml
                });

            currentArrayIndex = monthViewsArray.length-1;
            monthViewsArray[currentArrayIndex].object.anchors.topMargin = currentArrayIndex * 350;

            if(monthViewsArray[currentArrayIndex].object === null) console.log("Error creating object");
        }

        monthViewsArray[currentArrayIndex].object.model.append(allProjectsListModel.get(i));
        //kopirovanie projektov z modelu "vsetky" do modelu aktualneho MonthRow objektu

    }
    scrollViewId.contentHeight = monthViewsArray.length * 400;

}

function destroyMonthViews()
{
    for(var i=0; i<monthViewsArray.length; i++)
        monthViewsArray[i].object.destroy();

    monthViewsArray = [];
}


