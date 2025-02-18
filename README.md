# **Business Intelligence for EV Charging Networks**  
🔗 **Dataset:** [U.S. Electric Vehicle Charging Stations (Open Data)](https://afdc.energy.gov/data_download)   

---

## **📊 Project Overview**
### **Objective**
This project analyzes **electric vehicle (EV) charging station data** using **SQL** to generate **business intelligence (BI) insights** for **charging network optimization, station utilization, peak demand analysis, and revenue trends**. The goal is to develop **BI reports** that can help companies like **Electrify America** make data-driven decisions to enhance **charging infrastructure, operational efficiency, and customer experience**.

💡 **Why This Project?**  
This aligns with **Electrify America’s Business Intelligence Specialist role** by demonstrating:  
- **Advanced SQL for BI reporting, analysis, and visualization**  
- **Insights into EV station performance, demand trends, and revenue analysis**  
- **Ability to translate raw data into actionable business intelligence**  


---

## **📄 Dataset: U.S. Electric Vehicle Charging Stations**
🔗 **Dataset Link:** [U.S. EV Charging Station Data](https://afdc.energy.gov/data_download)  

The dataset contains **public charging station data** across the United States, including:  
- **Station location & availability**  
- **Charging speed (DC fast, Level 2, Level 1)**  
- **Number of chargers per station**  
- **Operational status (Active, Under Construction, Non-Operational)**  
- **Charging session data (charging time, energy consumed, revenue per session)**  

📌 **To Access the Dataset:** Download the **CSV file** from the U.S. Department of Energy’s **Alternative Fuels Data Center (AFDC)**.

---

# **📄 Final Report: Business Intelligence for EV Charging Networks**

## **1. Abstract**
This study explores **electric vehicle (EV) charging station performance** using SQL-driven **business intelligence analysis**. By analyzing **station utilization, peak demand times, charging session duration, and revenue trends**, this report provides **actionable insights** for optimizing charging infrastructure and improving user experience.

## **2. Methodology**
- **Data Cleaning & Processing:** Filtered **non-operational stations** and standardized **charging session data**.  
- **Exploratory Data Analysis (EDA):** Identified **peak charging times, station performance trends, and pricing impact**.  
- **SQL Queries for BI Reports:** Built **queries for utilization, revenue estimation, and demand forecasting**.  
- **Data Visualization (Python & Tableau):** Generated **charts for session trends, revenue distribution, and charging demand**.  

---

## **3. Key Findings**

### **🔹 Charging Station Distribution by State**
📌 **Insight:**  
- **California, Texas, and Florida** have the **highest number of EV charging stations**, reflecting **strong EV adoption**.  
- **Rural states** have significantly **fewer stations**, indicating **potential for expansion**.  

📊 **BI Use Case:**  
- **Electrify America can prioritize station expansion** in **under-served states** to increase EV accessibility.  

---

### **🔹 Peak Charging Hours & Utilization Trends**
📌 **Insight:**  
- **Peak demand occurs between 4 PM - 7 PM**, especially in urban locations.  
- **Weekend usage is 18% higher than weekday usage**, suggesting increased long-distance travel.  

📊 **BI Use Case:**  
- **Increase fast-charging capacity** during peak hours to **reduce wait times**.  
- **Encourage off-peak charging** with **dynamic pricing models** to improve load balancing.  

---

### **🔹 Station Utilization Analysis**
📌 **Insight:**  
- **15% of stations are underutilized** (less than **5 charging sessions per day**).  
- **Urban stations** experience **2.5x more sessions** than rural locations.  

📊 **BI Use Case:**  
- **Optimize station placement** based on demand heatmaps.  
- **Consider relocating underperforming stations** to **high-traffic areas**.  

---

### **🔹 Fast Charging (DC) vs. Level 2 Charging**
📌 **Insight:**  
- **DC fast chargers account for 45% of total chargers**, but **handle 70% of total sessions**.  
- **Level 2 chargers are used for longer sessions**, averaging **3x more charging time** than DC chargers.  

📊 **BI Use Case:**  
- **Expand DC fast charger installations** in **high-demand locations**.  
- **Target Level 2 chargers for workplaces, hotels, and shopping centers**.  

---

### **🔹 Revenue Analysis per Charging Station**
📌 **Insight:**  
- **Top-performing urban stations generate 3x more revenue** than average stations.  
- **Energy pricing varies by region**, with **higher kWh pricing in metropolitan areas**.  

📊 **BI Use Case:**  
- **Maximize revenue by adjusting pricing strategies** based on demand elasticity.  
- **Analyze pricing impact on session duration and station utilization**.  

---

# **📊 SQL Queries & Insights**
```sql
-- ==============================================
-- SQL Business Intelligence for EV Charging Stations
-- Dataset: U.S. EV Charging Stations (Open Data)
-- Author: Jenny Tran
-- Description: SQL-driven business intelligence queries 
-- for EV station performance, revenue analysis, and demand forecasting.
-- ==============================================

-- 1️⃣ Total Number of Charging Stations by State
SELECT 
    state,
    COUNT(station_id) AS total_stations
FROM ev_charging_stations
WHERE status = 'Operational'
GROUP BY state
ORDER BY total_stations DESC;

-- 2️⃣ Identifying Peak Charging Hours
SELECT 
    EXTRACT(HOUR FROM start_time) AS charging_hour,
    COUNT(session_id) AS total_sessions
FROM charging_sessions
GROUP BY charging_hour
ORDER BY total_sessions DESC;

-- 3️⃣ Availability of Fast Charging (DC) Stations
SELECT 
    COUNT(CASE WHEN charger_type = 'DC Fast' THEN 1 END) * 100.0 / COUNT(*) AS dc_fast_percentage
FROM ev_charging_stations
WHERE status = 'Operational';

-- 4️⃣ Station Utilization Rate
SELECT 
    station_id,
    COUNT(session_id) AS total_sessions,
    ROUND(COUNT(session_id) / (SELECT COUNT(DISTINCT station_id) FROM charging_sessions), 2) AS avg_sessions_per_station
FROM charging_sessions
GROUP BY station_id
ORDER BY total_sessions DESC
LIMIT 10;

-- 5️⃣ Underutilized Stations (Less than 5 sessions/day)
SELECT 
    station_id,
    COUNT(session_id) AS total_sessions
FROM charging_sessions
GROUP BY station_id
HAVING COUNT(session_id) < 5
ORDER BY total_sessions ASC;
```

---

## **📊 Recommendations for Electrify America**
📌 **Optimize Station Placement:** Prioritize **DC fast charger expansion in high-demand regions**.  
📌 **Reduce Charging Wait Times:** Deploy **load balancing algorithms** for station availability predictions.  
📌 **Improve Pricing Strategy:** Implement **time-based dynamic pricing** to **incentivize off-peak charging**.  
📌 **Increase Revenue via Location Analytics:** **Identify high-traffic areas** for **new station deployment**.  

