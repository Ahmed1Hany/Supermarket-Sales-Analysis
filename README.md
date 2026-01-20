# supermarket sales: end-to-end sql & power bi analysis

## 📌 project overview
an analytical deep dive into supermarket performance across three branches (alex, cairo, giza). this project demonstrates a full data pipeline: from **sql data engineering** in postgresql to **executive dashboards** in power bi.



---

## 🛠️ tech stack
* **database:** postgresql (pgadmin 4)
* **visualization:** power bi desktop
* **language:** sql, dax
* **dataset:** [kaggle supermarket sales](https://www.kaggle.com/datasets/faresashraf1001/supermarket-sales)

---

## ⚙️ data engineering & etl (postgresql)
i performed rigorous data cleaning and validation using sql to ensure report accuracy:
* **environment fix:** resolved mdy date format conflicts using:
    `alter database supermarket_sales_db set datestyle to "iso, mdy";`
* **integrity audit:** verified 1,000 records where `total = cogs + tax`.
* **eda discovery:** identified that gross income follows a perfectly linear distribution relative to sales, suggesting a synthetic dataset with fixed margin rules.

---

## 🧪 power bi logic (dax measures)
to power the dynamic visuals, i authored custom dax measures for real-time kpi tracking:

* **total revenue:** `total revenue = sum(sales[total])`
* **gross margin %:** `gross margin % = divide(sum(sales[gross_income]), [total revenue], 0)`
* **average rating:** `avg rating = average(sales[rating])`
* **member sales ratio:** `member sales = calculate([total revenue], sales[customer_type] = "member")`

---

## 🔍 key insights
### 1. the rush hour pulse
sql extraction identified peak traffic windows:
* **13:00, 15:00, and 19:00** are the primary transaction spikes.
* **strategy:** increase checkout staffing during these windows to reduce wait times.

### 2. branch performance
* **alex and cairo** show nearly identical revenue distributions, suggesting market saturation parity in these regions.

### 3. payment trends
* **e-wallets** are the most popular payment method among members, while cash remains common for non-members.

---

## 📊 dashboard preview
![executive summary](Images/dashboard_p1.png)
![customer behaviour](Images/dashboard_p2.png)

---

## 📂 project structure
* `/sql_scripts`: full `analysis_queries.sql` including window functions and ctes.
* `/dataset`: raw `sales.csv` source data.
* `/reports`: interactive `.pbix` power bi file.

---

## 🚀 actionable recommendations
1.  **staffing optimization:** shift part-time employee hours to cover the 13:00–15:00 and 18:00–20:00 peaks.
2.  **loyalty programs:** launch "e-wallet" specific promotions to convert "normal" customers into "members."
3.  **inventory management:** increase stock for high-performing categories (food & fashion) during weekend peak hours.

---

## ✉️ contact & links
* **author:** Ahmed Hany
* **linkedin:** (https://www.linkedin.com/in/ahmed-hany-aa0309265/)

