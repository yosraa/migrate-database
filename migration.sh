
usage() {
  echo "Script to Migrate the local Postgres database to AWS RDS."
  echo "Available actions:"
  echo " -h : show this help message"
  echo " -d : perform the dump"
  echo " -r : perform the restore"
  echo " -p : port number of the database (default is 5432"
  echo " -u : username of the database"
  echo " -n : name of the database"

}
PORT=5432
USER=amin
DATABASE=migration
ENDPOINT=your-rds-endpoint.rds.amazonaws.com
ACTION=NONE

while getopts 'hdrp:u:n:' flag; do
  case "${flag}" in
    h)
      usage
      exit 1
      ;;
    d)
      ACTION=DUMP
      ;;
    r)
      ACTION=RESTORE
      ;;
    p)
      PORT=${OPTARG}
      ;;
    u)
      USER=${OPTARG}
      ;;
    n)
      DATABASE=${OPTARG}
      ;;
    *)
      echo "Unkonw option ${flag}"
      usage
      exit 2
  esac
done

dump(){
  pg_dump -h localhost -U username -F c -b -v -f /path_to_backup/backupfile.dump dbname

}

restore()
{
  pg_restore -h $ENDPOINT -U username -d dbname -v /path_to_backup/backupfile.dump
}


if [ $ACTION == "DUMP"];then
  dump
  echo $DATABASE > dumps/source.txt
elif [ $ACTION == "RESTORE"]; then
  restore
else
    echo "Urecognized command"
    usage
    exit 4
fi


echo "Done"


