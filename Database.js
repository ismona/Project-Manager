/*

VYTVORENIE DB

*/

function init() {
    //console.log("fungujem")

    var db = LocalStorage.openDatabaseSync("ProjectManager", "", "Projektovy manazer", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS projects (projectId INTEGER NOT NULL PRIMARY KEY, projectName TEXT NOT NULL, clientName TEXT NOT NULL, contact INTEGER NOT NULL, address TEXT NOT NULL, realizationAdd TEXT NOT NULL, realizationTypeId INTEGER NOT NULL, personId INTEGER NOT NULL, todayDate TEXT NOT NULL, testDate TEXT NOT NULL, launchDate TEXT NOT NULL, special TEXT, notes TEXT, colorRectangle TEXT, FOREIGN KEY (realizationTypeId) REFERENCES realizationTypes (realizationTypeId), FOREIGN KEY (personId) REFERENCES persons (personId))');
        })

        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS persons (personId INTEGER NOT NULL PRIMARY KEY, personName TEXT NOT NULL)');
        })

        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS noteTypes (noteTypeId INTEGER NOT NULL PRIMARY KEY, noteType TEXT NOT NULL)');
        })

        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS realizationTypes (realizationTypeId INTEGER NOT NULL PRIMARY KEY, realizationType TEXT NOT NULL)');
        })

        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS notes (noteId INTEGER NOT NULL PRIMARY KEY, noteName TEXT NOT NULL, noteTypeId INTEGER NOT NULL, messageNote TEXT NOT NULL, personId INTEGER NOT NULL, projectId INTEGER NOT NULL, todayDate TEXT NOT NULL, FOREIGN KEY (noteTypeId) REFERENCES noteTypes (noteTypeId), FOREIGN KEY (personId) REFERENCES persons (personId), FOREIGN KEY (projectId) REFERENCES projects (projectId))');
        })
        db.transaction(function(tx){
            tx.executeSql('CREATE TRIGGER IF NOT EXISTS deletingPersonTrigger BEFORE DELETE ON persons BEGIN UPDATE projects SET personId = 0 WHERE personId = OLD.personId; UPDATE notes SET personId = 0 WHERE personId = OLD.personId; END;');
        })

        db.transaction(function(tx){
            tx.executeSql('CREATE TRIGGER IF NOT EXISTS deletingNoteTypeTrigger BEFORE DELETE ON noteTypes BEGIN UPDATE notes SET noteTypeId = 0 WHERE noteTypeId = OLD.noteTypeId; END;');
        })
        db.transaction(function(tx){
            tx.executeSql('CREATE TRIGGER IF NOT EXISTS deletingRealizationTypeTrigger BEFORE DELETE ON realizationTypes BEGIN UPDATE projects SET realizationTypeId = 0 WHERE realizationTypeId = OLD.realizationTypeId; END;');
        })

    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function insertTriggerData(){
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO persons(personId, personName) VALUES (0, "Vymazaný užívateľ")');
    })
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO noteTypes(noteTypeId, noteType) VALUES (0, "Vymazaný typ")');
    })
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO realizationTypes(realizationTypeId, realizationType) VALUES (0, "Vymazaný typ")');
    })
}


/*

OTVORENIE DATABAZY

*/

function open()
{
    //console.log("otvaram")
    try {
        var db = LocalStorage.openDatabaseSync("ProjectManager", "",
                                               "Projektovy manazer", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}


/*
  VYMAZANIE TABULIEK
*/

function deleteTables() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TABLE IF EXISTS notes')
    })
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TABLE IF EXISTS projects')
    })
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TABLE IF EXISTS persons')
    })
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TABLE IF EXISTS noteTypes')
    })
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TABLE IF EXISTS realizationTypes')
    })
    /*
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TRIGGER IF EXISTS deletingPersonTrigger')
    })
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TRIGGER IF EXISTS deletingNoteTypeTrigger')
    })
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'DROP TRIGGER IF EXISTS deletingRealizationTypeTrigger')
    })
    */
}



/******************************************* PROJEKT *******************************************************/

/*

VLOZENIE PROJEKTU / INSERT

*/



function insert(projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO projects(projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle]);
    })

}

/*

VYBRATIE PROJEKTU / SELECT

*/
function selectProject() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT projectId, projectName, todayDate FROM projects ORDER BY todayDate DESC')
        for (var i = 0; i < results.rows.length; i++) {
            nameModel.append({
                                 projectName: results.rows.item(i).projectName,
                                 todayDate: results.rows.item(i).todayDate,
                                 projectId: results.rows.item(i).projectId
                             })
        }
    })
}

/*

VYBRATIE ZOZNAMU PROJEKTOV NA KARTU HOME

*/

function selectProjectGeneral() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT projectId, clientName, projectName, todayDate, realizationType, colorRectangle FROM projects INNER JOIN realizationTypes ON realizationTypes.realizationTypeId = projects.realizationTypeId INNER JOIN persons ON persons.personId = projects.personId ORDER BY todayDate DESC')
        for (var i = 0; i < results.rows.length; i++) {
            generalListModel.append({
                                        projectName: results.rows.item(i).projectName,
                                        clientName: results.rows.item(i).clientName,
                                        todayDate: results.rows.item(i).todayDate,
                                        realizationType: results.rows.item(i).realizationType,
                                        colorRectangle: results.rows.item(i).colorRectangle,
                                        projectId: results.rows.item(i).projectId
                                    })
        }

    })
}

/*

VYBRATIE DAT K PROJEKTOM NA KARTU ZOZNAM

*/

function selectDates() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT projectId, projectName, todayDate, testDate, launchDate FROM projects ORDER BY todayDate DESC')
        for (var i = 0; i < results.rows.length; i++) {
            var lastNote = tx.executeSql('SELECT notes.todayDate FROM notes WHERE notes.projectId='+results.rows.item(i).projectId+' ORDER BY notes.todayDate DESC LIMIT 1')

            if (lastNote.rows.length === 0){
                var lastDateMsg = "nemá záznam"
            } else {
                lastDateMsg = lastNote.rows.item(0).todayDate
            }

            allProjectsListModel.append({
                                            projectName: results.rows.item(i).projectName,
                                            todayDate: results.rows.item(i).todayDate,
                                            testDate: results.rows.item(i).testDate,
                                            launchDate: results.rows.item(i).launchDate,
                                            projectId: results.rows.item(i).projectId,
                                            lastDate: lastDateMsg
                                        })
        }
    })
}



/*

VYBER VSETKYCH DAT KU KONKRETNEMU PROJEKTU / SELECT

*/
function selectCurrentProject(idProject) {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT projectName, clientName, contact, address, realizationAdd, realizationTypes.realizationType, persons.personName, todayDate, testDate, launchDate, special, notes FROM projects INNER JOIN realizationTypes ON realizationTypes.realizationTypeId = projects.realizationTypeId INNER JOIN persons ON persons.personId = projects.personId WHERE projects.projectId = ?', [idProject])
        for (var i = 0; i < results.rows.length; i++) {
            currentProListModel.append({
                                           projectName: results.rows.item(i).projectName,
                                           clientName: results.rows.item(i).clientName,
                                           contact: results.rows.item(i).contact,
                                           address: results.rows.item(i).address,
                                           realizationAdd: results.rows.item(i).realizationAdd,
                                           realizationType: results.rows.item(i).realizationType,
                                           personName: results.rows.item(i).personName,
                                           todayDate: results.rows.item(i).todayDate,
                                           testDate: results.rows.item(i).testDate,
                                           launchDate: results.rows.item(i).launchDate,
                                           special: results.rows.item(i).special,
                                           notes: results.rows.item(i).notes
                                       })
        }

    })
}


/*

VYBER DAT DO FORMULARA PRI UPRAVE PROJEKTU

*/

function findColorId(criteria) {
  for(var i=0; i < listModelColors.count; ++i)
      if (criteria(listModelColors.get(i)))
        return i;
  return null;
}

function selectEditProject(idProject) {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT projectName, clientName, contact, realizationAdd, address, colorRectangle, realizationTypeId, todayDate, testDate, launchDate, special, notes, personId ' +
                    'FROM projects WHERE projects.projectId = ?',
                    [idProject])
        if (results.rows.length > 0) {
            var result = results.rows.item(0)

            projectNameId.text = result.projectName;
            clientId.text = result.clientName;
            contactId.text = result.contact;
            addressId.text = result.address;
            realizationId.text = result.realizationAdd;
            comboRealization.currentIndex = result.realizationTypeId - 1;
            todayDateId.text = result.todayDate;
            testDateId.text = result.testDate;
            launchDateId.text = result.launchDate;
            specialId.text = result.special;
            notesId.text = result.notes;
            comboPerson.currentIndex = result.personId - 1;
            colors.currentIndex = findColorId(function(item) {return item.value === result.colorRectangle})
        } else {
            console.log("n");
        }
    })
}



/*

UPRAVA PROJEKTU

*/

function updateProject(projectId, projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql(
                    'UPDATE projects SET projectName=?, clientName=?, contact=?, address=?, realizationAdd=?, realizationTypeId=?, personId=?, todayDate=?, testDate=?, launchDate=?, special=?, notes=?, colorRectangle=? WHERE projectId = ?',
                    [projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle, projectId])
    })
}


/*

VYMAZANIE PROJEKTU

*/

function deleteProject(id)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM projects where projectId = ?', [id])
    })
}







/******************************************************* ZAZNAM *****************************************************************/


/*

VYBRATIE ZAZNAMU NA KARTE HOME / SELECT

*/


function selectNoteGeneral() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT noteId, noteName, notes.todayDate, noteType, colorRectangle FROM notes INNER JOIN noteTypes ON noteTypes.noteTypeId = notes.noteTypeId INNER JOIN projects ON notes.projectId = projects.projectId ORDER BY notes.todayDate DESC')
        for (var i = 0; i < results.rows.length; i++) {
            generalListModelNote.append({
                                            noteName: results.rows.item(i).noteName,
                                            todayDate: results.rows.item(i).todayDate,
                                            noteType: results.rows.item(i).noteType,
                                            noteId: results.rows.item(i).noteId,
                                            colorRectangle: results.rows.item(i).colorRectangle
                                        })
        }

    })
}

/*

VLOZENIE NOVEHO ZAZNAMU / INSERT

*/


function insertNote(noteName, noteTypeId, messageNote, personId, projectId, todayDate)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO notes(noteName, noteTypeId, messageNote, personId, projectId, todayDate) VALUES (?,?,?,?,?,?)', [noteName, noteTypeId, messageNote, personId, projectId, todayDate]);
    })

}


/*

VYBER ZAZNAMOV PRE KONKRETNY PROJEKT

*/

function selectProjectNotes(id) {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT notes.noteId, noteName, notes.todayDate, noteType, colorRectangle FROM notes INNER JOIN noteTypes ON notes.noteTypeId = noteTypes.noteTypeId INNER JOIN projects ON notes.projectId = projects.projectId WHERE notes.projectId = ? ORDER BY notes.todayDate DESC',[id])
        for (var i = 0; i < results.rows.length; i++) {
            projectNotesListModel.append({
                                             noteName: results.rows.item(i).noteName,
                                             todayDate: results.rows.item(i).todayDate,
                                             noteType: results.rows.item(i).noteType,
                                             noteId: results.rows.item(i).noteId,
                                             colorRectangle: results.rows.item(i).colorRectangle
                                         })
        }
    })
}


/*

VYBER DAT PRE ZOBRAZENIE KONKRETNEHO ZAZNAMU / SELECT

*/

function selectCurrentNote(idNote) {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT notes.noteName, notes.messageNote, notes.todayDate, persons.personName, projects.projectName, noteTypes.noteType FROM notes INNER JOIN projects ON projects.projectId = notes.projectId INNER JOIN noteTypes ON notes.noteTypeId = noteTypes.noteTypeId INNER JOIN persons ON persons.personId = notes.personId WHERE notes.noteId = ?', [idNote])
        for (var i = 0; i < results.rows.length; i++) {
            currentNoteListModel.append({
                                            noteName: results.rows.item(i).noteName,
                                            noteType: results.rows.item(i).noteType,
                                            messageNote: results.rows.item(i).messageNote,
                                            personName: results.rows.item(i).personName,
                                            projectName: results.rows.item(i).projectName,
                                            todayDate: results.rows.item(i).todayDate
                                        })
        }
    })
}



/*

VYBER DAT PRE ZOBRAZENIE VO FORMULARI PRI UPRAVE ZAZNAMU

*/

function selectEditNote(idNote) {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT noteName, messageNote, todayDate, personId, noteTypeId, projectId FROM notes WHERE noteId = ?', [idNote])
        if (results.rows.length > 0) {
            var result = results.rows.item(0)
            project.text = result.projectId;
            todayDateId.text = result.todayDate;
            noteMsgId.text = result.messageNote;
            noteNameId.text = result.noteName;
            comboPerson.currentIndex = result.personId - 1;
            comboNote.currentIndex  = result.noteTypeId - 1;
        } else {
            console.log("n");
        }
    })
}


/*

UPRAVIT ZAZNAM
UPDATE NOTE

*/

function updateNote(noteId, noteName, noteTypeId, messageNote, personId, projectId, todayDate)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql(
                    'UPDATE notes SET noteName=?, noteTypeId=?, messageNote=?, personId=?, projectId=?, todayDate=? WHERE noteId = ?', [noteName, noteTypeId, messageNote, personId, projectId, todayDate, noteId])
    })
}


/*

 VYMAZANIE ZAZNAMU

*/

function deleteNote(id)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM notes where noteId = ?', [id])
    })
}


function deleteMultipleNotes(id)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM notes where projectId = ?', [id])
    })
}


/*

VYBRATIE DAT DO COMBOBOXOV PRE

OSOBU

TYP ZAZNAMU

TYP REALIZACIE

*/


/* COMBO PERSON */

function loadComboPerson() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT personId, personName FROM persons WHERE personId IS NOT 0')
        for (var i = 0; i < results.rows.length; i++) {
            comboPersonListModel.append({
                                            personId: results.rows.item(i).personId,
                                            personName: results.rows.item(i).personName
                                        })
        }
    })
}

/* COMBO NOTETYPE */

function loadComboNote() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT noteTypeId, noteType FROM noteTypes WHERE noteTypeId IS NOT 0')
        for (var i = 0; i < results.rows.length; i++) {
            comboListModelNote.append({
                                          noteType: results.rows.item(i).noteType,
                                          noteTypeId: results.rows.item(i).noteTypeId
                                      })
        }
    })
}


/* COMBO REALIZATION */

function loadComboRealization() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT realizationTypeId, realizationType FROM realizationTypes WHERE realizationTypeId IS NOT 0')
        for (var i = 0; i < results.rows.length; i++) {
            comboListModelRealization.append({
                                                 realizationType: results.rows.item(i).realizationType,
                                                 realizationTypeId: results.rows.item(i).realizationTypeId
                                             })
        }
    })
}



/*

VYBER DAT DO CHECKBOXOV

PRE OSOBU
TYP ZAZNAMU
TYP REALIZACIE

*/

/* CHECK PERSON */

function loadPerson() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT personId, personName FROM persons WHERE personId IS NOT 0')
        for (var i = 0; i < results.rows.length; i++) {
            checkListPersonModel.append({
                                            personName: results.rows.item(i).personName,
                                            personId: results.rows.item(i).personId
                                        })
        }
    })
}


/* CHECK NOTETYPE */

function loadNote() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT noteTypeId, noteType FROM noteTypes WHERE noteTypeId IS NOT 0')
        for (var i = 0; i < results.rows.length; i++) {
            checkListNoteModel.append({
                                          noteType: results.rows.item(i).noteType,
                                          noteTypeId: results.rows.item(i).noteTypeId
                                      })
        }
    })
}

/* CHECK REALIZATIONTYPE */

function loadRealTypes() {
    var db = open()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT realizationTypeId, realizationType FROM realizationTypes WHERE realizationTypeId IS NOT 0')
        for (var i = 0; i < results.rows.length; i++) {
            checkListRealModel.append({
                                          realizationType: results.rows.item(i).realizationType,
                                          realizationTypeId: results.rows.item(i).realizationTypeId
                                      })
        }
    })
}





/****************************************** SPRAVA TABULIEK ************************************************************/



/* delete person */

function deletePerson(id)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM persons where personId = ?', [id])
    })
}

/* delete note type */

function deleteNoteType(id)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM noteTypes where noteTypeId = ?', [id])
    })
}

/* delete realization type */

function deleteRealType(id)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM realizationTypes where realizationTypeId = ?', [id])
    })
}


/* insert noteType */

function insertNoteType(noteType)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO noteTypes(noteType) VALUES (?)', [noteType]);
    })

}


/* insert realizationType */

function insertRealizationType(realizationType)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO realizationTypes(realizationType) VALUES (?)', [realizationType]);
    })

}

/* insert person */

function insertPerson(personName)
{
    var db = open()
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO persons(personName) VALUES (?)', [personName]);
    })

}


