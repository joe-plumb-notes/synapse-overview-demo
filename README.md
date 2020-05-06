# Azure Synapse Analytics Overview Demo
I couldn't find the demo assets very easily to showcase the Synapse capabilites, so I have compiled and made these available for those who need them.

## Setup
1. Ask me for access to the data for the demo. I can make this available in a storage account so you can copy it to your own, or you can just use the data in place.
1. Import the assets from the `/assets` folder.
1. Set up your linked services. This should include:
    - PowerBI Workspace
    - Azure Machine Learning Service
    - Azure Functions
    - Azure Databricks
    - At least one Azure Storage Account (ADLS)
1. Create the demo Pipelines:
    - Azure ML pipeline:
    ![image with layout of machine learning pipeline](/img/azuremlpipeline.png)
    - Databricks Machine Learning pipeline:
    ![image with layout of databricks pipeline](/img/databrickspipeline.png)
    - Get Weather pipeline
    ![image with layout of weather pipeline](/img/getweather.png)
    NB: When you are creating these, make sure you are satisfying the publish criteria by using the ![validate](/img/validate.png) button. _These pipelines won't actually do anything_, but are just there to show what you could do using the service. Join the pipelines up as per the images. Leave the `Get Metadata` node floating on the Azure ML pipeline. You will use this in the demo.
    - Example Data Flow (this is in the Develop Hub). Use any data set and create something that validates.
    ![image of data flow](/img/dataflow.png)
1. Run the `CreateHiveTables` notebook to create dummy hive tables
1. Run the `GetSampledTaxiData` notebook to get the sample taxi data. Make sure to change the `abfs` path in cell 2 to store it in your own account.
1. Update the `NYCTaxi-Predict-Tip-PySpark.ipynb` data location (cell 4)
1. Open the PowerBI report in PowerBI Desktop. Check this works. Publish the report to the same workspace you have linked to Azure Synapse.

## Demo script/pointers
The demo follows the same flow that you may have seen others deliver. Key talking points:
- Synapse Analytics Studio – unified interface and the *home of enterprise analytics* where data engineers, data scientists, and IT professionals can *collaborate on enterprise analytics projects*.
- Home page shows the things you might expect to find… things I’ve been working on, documentation  and *activity hubs*. 
- *Data Hub* – I can view all my data in one place, storage accounts, enterprise data warehouse, any other databases, and *all secured via AAD* – I can only see and access the things that I have permission to see.
- Navigate through folders in `nyctaxi` dataset, pick a parquet file, right click.
- "Depending on my skills, I can choose the experience that is *right for me*"
    - Spark notebook (execute this command, talk about Spark cluster, might take a minute to start up), then go to *Develop Hub* and open `Demo Script.sql`
    - SQL on demand – serverless SQL queries using distributed data processing for large scale data and compute against the data lake. Step through these queries. First one, use this to talk about the on-demand engine, then with the others, show the below visualisations.
- "Quick access to visualisations to enable exploratory data analysis"
    1.	Pie chart, VENDORID, PassengerCount
    2.	Column, current_year, rides_per_year
    3.	Same
- Go back to the Spark Notebook, view results. "We can integrate these straight with our operational pipelines". Click `Add to Pipeline` ![add to pipeline icon](/img/addtopipeline.png), then select `Azure ML Pipeline`. This will take you to the:
- *Orchestration Hub* - where we develop these pipelines. Pipeline here is a *logical flow of a set of activities*. Steps that can call out to any of the linked services. Join the notebook node in between the `Get Metadata` and `Azure ML` nodes. Join them. Show other nodes in the pallete of interest E.g. pig script to push work into my HDI cluster. 
- "Some people… don’t like to code. Data flows,  which can also  be brought into Pipelines, are a low code approach for Graphical, scalable pipelines". Show the example data flow, and show the range of different actions e.g. joins, derived columns, transformations, etc.
- Final piece of develop, is PowerBI. "Integrated right alongside in the studio, so users can build reports and make them available to the business". Load the report, talk through how this can be linked with Synapse to query live data from the warehouse.
- Show *Monitor*, and navigate to Spark and SQL activities, user monitoring, query behavior etc.
- Show *Manage*, and linked services, click add new service and show breadth of options to connect to.

Thats it!


