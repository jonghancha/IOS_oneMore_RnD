
import Foundation
import SQLite3
// 코코아팟 없이 걍 이걸로 임포트 ㅋ
class DBHelper
{
    init()
    {
        db = openDatabase()
        print("---22")
        createTable()
        // 테이블이랑 디비 만들어주는거
    }
    let dbPath: String = "myDataNew1.sqlite"
    //let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS WorkoutLog(exerciseSequenceNumer INTEGER PRIMARY KEY, exerciseName TEXT, exerciseHow TEXT, exerciseWhen TEXT, exerciseJudgment TEXT, exerciseComment TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        print("-----11")
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(exerciseSequenceNumer:Int, exerciseName:String, exerciseHow:String, exerciseWhen:String, exerciseJudgment:String, exerciseComment: String)
    {
//        let workoutLogs = read()
//        for w in workoutLogs
//        {
//            if w.exerciseSequenceNumer == exerciseSequenceNumer
//            {
//                return
//            }
//        }
        let insertStatementString = "INSERT INTO WorkoutLog(exerciseSequenceNumer, exerciseName, exerciseHow, exerciseWhen, exerciseJudgment, exerciseComment) VALUES (NULL, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
          
            //sqlite3_bind_int(insertStatement, 1, Int32(exerciseSequenceNumer)
            sqlite3_bind_text(insertStatement, 1, (exerciseName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (exerciseHow as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (exerciseWhen as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (exerciseJudgment as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (exerciseComment as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                print("\(exerciseSequenceNumer) | \(exerciseName) | \(exerciseHow) | \(exerciseWhen) | \(exerciseJudgment) | \(exerciseComment) <--- 확인용")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [workoutLog] {
        let queryStatementString = "SELECT * FROM WorkoutLog"
        var queryStatement: OpaquePointer? = nil
        var psns : [workoutLog] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let exerciseSequenceNumer = sqlite3_column_int(queryStatement, 0)
                let exerciseName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let exerciseHow = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let exerciseWhen = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let exerciseJudgment = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let exerciseComment = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                //let year = sqlite3_column_int(queryStatement, 2)
                psns.append(workoutLog(exerciseSequenceNumer: Int(exerciseSequenceNumer), exerciseName: exerciseName, exerciseHow: exerciseHow, exerciseWhen: exerciseWhen, exerciseJudgment: exerciseJudgment, exerciseComment: exerciseComment))
                print("Query Result:")
                print("\(exerciseSequenceNumer) | \(exerciseName) | \(exerciseHow) | \(exerciseWhen) | \(exerciseJudgment) | \(exerciseComment)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(exerciseSequenceNumer : Int) {
        let deleteStatementStirng = "DELETE FROM WorkoutLog WHERE exerciseSequenceNumer = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(exerciseSequenceNumer))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func updateByID(exerciseWhen : String, exerciseComment : String) {
        let updateStatementStirng = "UPDATE WorkoutLog set exerciseComment = ? WHERE exerciseWhen = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(updateStatement, 1, (exerciseComment as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (exerciseWhen as NSString).utf8String, -1, nil)

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updates row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    
    
}
