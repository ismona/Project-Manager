function buildHTML_project()
{
    var html = "";

    html += "<h1>"+ currentProListModel.get(0).projectName +"</h1>" + '\n'

    html += "<table>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Dátum vytvorenia:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).todayDate +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Testovanie:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).testDate +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Spustenie:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).launchDate +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "</table>" + '\n'

    html += "<hr>" + '\n'

    html += "<table>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Meno zákazníka:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).clientName +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Kontakt:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).contact +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Adrea:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).address +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Typ realizácie:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).realizationType +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Adresa realizácie:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).realizationAdd +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "</table>" + '\n'

    html += "<hr>" + '\n'

    html += "<div>" + '\n'
    html += "   <h3>Špeciálne požiadavky:</h3>" + '\n'
    html += "   <p>"+ currentProListModel.get(0).special +"</p>" + '\n'
    html += "</div>" + '\n'
    html += "<div>" + '\n'
    html += "   <h3>Poznámky:</h3>" + '\n'
    html += "   <p>"+ currentProListModel.get(0).notes +"</p>" + '\n'
    html += "</div>" + '\n'

    html += "<hr>" + '\n'

    html += "<table>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td> Zodpovedná osoba:</td>" + '\n'
    html += "        <td>"+ currentProListModel.get(0).personName +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "</table>" + '\n'


    console.log(html);
    return html;
}

function buildHTML_note()
{
    var html = "";

    html += "<h1>"+ currentNoteListModel.get(0).noteName +"</h1>" + '\n'
    html += "<div>" + '\n'
    html += "   <p>Zaradený k projektu:</p>" + '\n'
    html += "   <h3>"+ currentNoteListModel.get(0).projectName + "</h3>" + '\n'
    html += "</div>" + '\n'

    html += "<hr>" + '\n'

    html += "<table>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Dátum vytvorenia:</td>" + '\n'
    html += "        <td>"+ currentNoteListModel.get(0).todayDate +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Zodpovedná osoba:</td>" + '\n'
    html += "        <td>"+ currentNoteListModel.get(0).personName +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Typ záznamu:</td>" + '\n'
    html += "        <td>"+ currentNoteListModel.get(0).noteType +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "    <tr>" + '\n'
    html += "        <td>Správa:</td>" + '\n'
    html += "        <td>"+ currentNoteListModel.get(0).messageNote +"</td>" + '\n'
    html += "    </tr>" + '\n'
    html += "</table>" + '\n'

    console.log(html);
    return html;

}
