import org.apache.avro.Schema;
import org.apache.avro.file.DataFileReader;
import org.apache.avro.generic.GenericDatumReader;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.DatumReader;
import org.apache.avro.mapred.FsInput;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.AvroFSInput;
import org.apache.hadoop.fs.Path;

import java.io.IOException;


public class SchemaReader {
   private Configuration configuration = new Configuration();

    /***
     * Create path to hdfs file
     * @param path
     */
    public static void readSchema(Path path) throws IOException {
        FsInput inputFile = new FsInput(path,new Configuration());
        DatumReader<GenericRecord> datumReader = new GenericDatumReader<>();
        DataFileReader<GenericRecord> dataFileReader  = new DataFileReader<>(inputFile,datumReader);
        Schema schema = dataFileReader.getSchema();
        System.out.println(schema);
    }

    public static void main(String[] args) {
        try {
            readSchema(new Path(args[0]));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
