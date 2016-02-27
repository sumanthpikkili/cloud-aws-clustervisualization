/*
 * Author Name: Sumanth Pikkili
 * UTA ID: 1001100941
 * Course Number: CSE 6339 (Cloud Computing)
 * Assignment 5: Visualizing Clustering
 */


import weka.core.Instances;
import weka.core.converters.ArffSaver;
import weka.core.converters.CSVLoader;
import weka.clusterers.SimpleKMeans;

import java.io.BufferedReader;
import java.io.FileReader;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;



public class wekacluster extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public wekacluster() {
		super();

	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String file_name = null;
		PrintWriter outwrite=response.getWriter();


		try {

			List<FileItem> clusitems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

			//Number of Clusters
			String k = null;

			// If the item is a form field, get the field name and the field value

			for (FileItem item : clusitems) {
				if (item.isFormField()) {

					String fieldName = item.getFieldName();
					String fieldValue = item.getString();
					k=fieldValue;

					if(fieldName.equals("k"))
					{
						k=fieldValue;
					}

				} else {

					file_name = FilenameUtils.getName(item.getName());
					InputStream file_content = item.getInputStream();
					File dest_file = new File(file_name);

					//copy the file content to the target file
					FileUtils.copyInputStreamToFile(file_content,dest_file);

				}

			}

			//Load the CSV File

			CSVLoader csv_file = new CSVLoader();
			csv_file.setSource(new File(file_name));

			//Fetch data from the csv file
			Instances data = csv_file.getDataSet();
			String[] fileParts=file_name.split("\\.");

			// save as .ARFF file

			ArffSaver saver = new ArffSaver();
			saver.setInstances(data);
			saver.setFile(new File(file_name));
			saver.setDestination(new File(fileParts[0]+".arff"));
			saver.writeBatch();

			//Start Kmeans clustering
			SimpleKMeans kmeans = new SimpleKMeans();

			kmeans.setSeed(10);


			kmeans.setPreserveInstancesOrder(true);

			//Set the number of clusters
			kmeans.setNumClusters(Integer.parseInt(k));

			//Read the .arff file

			BufferedReader data_file = readDataFile(fileParts[0]+".arff"); 
			Instances data_instance = new Instances(data_file);

			//Creating avg temp and avg precp array lists

			ArrayList<Double> avgtemp=new ArrayList<Double>();
			ArrayList<Double> avgprecp=new ArrayList<Double>();

			//Fetching the data
			for(int i=0;i<data_instance.numInstances();i++)
			{
				System.out.println(data_instance.instance(i).value(1));
				avgtemp.add(data_instance.instance(i).value(1));
				avgprecp.add(data_instance.instance(i).value(2));
			}

			//Build the cluster
			int i=0;
			kmeans.buildClusterer(data_instance);

			// This array returns the cluster number (starting with 0) for each instance. The array has as many elements as the number of instances

			int[] assignment = kmeans.getAssignments();

			//Creating the JSON Array
			JsonArray clust_json=new JsonArray();

			for(int clusterNum : assignment) {

				JsonObject cluster_data=new JsonObject();
				cluster_data.addProperty("mag", avgtemp.get(i));
				cluster_data.addProperty("precp", avgprecp.get(i));
				cluster_data.addProperty("clusternum", clusterNum);
				clust_json.add(cluster_data);	   	
				i++;
			}

			System.out.println(clust_json);
			request.setAttribute("clusterjson", clust_json);
			request.setAttribute("k", k);

			//Redirect to showcluster jsp page and show visualisation of clusters
			RequestDispatcher dispatch=request.getRequestDispatcher("showcluster_test.jsp");
			dispatch.forward(request, response);

		}
		catch(Exception e)
		{
			outwrite.println(file_name);
			outwrite.println(e);
			outwrite.print(e.getStackTrace());
		}

	}	

	public static BufferedReader readDataFile(String filename) {
		BufferedReader inputReader = null;

		try {
			inputReader = new BufferedReader(new FileReader(filename));
		} catch (FileNotFoundException ex) {
			System.err.println("File not found: " + filename);
		}

		return inputReader;
	}

}
