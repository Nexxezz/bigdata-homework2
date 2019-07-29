import org.apache.avro.Schema;
import org.apache.avro.file.DataFileReader;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericDatumReader;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.DatumReader;
import org.apache.avro.mapred.FsInput;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.parquet.hadoop.ParquetFileReader;
import org.apache.parquet.hadoop.ParquetReader;
import org.apache.parquet.hadoop.metadata.ParquetMetadata;
import org.apache.parquet.schema.MessageType;

import java.io.IOException;

import static org.apache.parquet.format.converter.ParquetMetadataConverter.NO_FILTER;


public class SchemaReader {

    /***
     * Create path to hdfs file
     * @param path
     */
    public static void readAvroSchema(Path path) throws IOException {
        FsInput inputFile = new FsInput(path, new Configuration());
        DatumReader<GenericRecord> datumReader = new GenericDatumReader<>();
        DataFileReader<GenericRecord> dataFileReader = new DataFileReader<>(inputFile, datumReader);
        Schema schema = dataFileReader.getSchema();
        System.out.println(schema);
    }

    public static void readParquetFile(Path path) throws IOException {
        {
            ParquetMetadata metaData = ParquetFileReader.readFooter(new Configuration(), path, NO_FILTER);
            MessageType schema = metaData.getFileMetaData().getSchema();
            System.out.println(schema.toString());
        }

    }

    public static void main(String[] args) {
        try {
            if (args[0].endsWith(".avro")) {
                {
                    readAvroSchema(new Path(args[0]));
                }
            }
            if (args[0].endsWith(".parquet")) {

                readParquetFile(new Path(args[0]));
            }
            System.out.println("Not found:(");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
