use finance_db;
select * from finance_dataset;
select COUNT(CustomerID) AS Total_Customer
	from finance_dataset; 
 select sum(TransactionID) 
	from finance_dataset;
    
select * from finance_dataset
WHERE AccountType = 'Savings';   

select count(Branch),Branch from finance_dataset
group by AccountType; 

/*If you want count of branches per AccountType */
SELECT AccountType, COUNT(DISTINCT Branch) AS BranchCount
FROM finance_dataset
GROUP BY AccountType;

/* If you want transaction count per Branch */
SELECT Branch, COUNT(*) AS TransactionCount
FROM finance_dataset
GROUP BY Branch;

/* If you want transaction count per Branch & AccountType */
SELECT AccountType, Branch, COUNT(*) AS TransactionCount
FROM finance_dataset
GROUP BY AccountType, Branch;

/* Account type in each branch*/
SELECT Branch, AccountType, COUNT(*) AS TransactionCount
FROM finance_dataset
GROUP BY Branch, AccountType
ORDER BY Branch, AccountType;

/* how many unique customers use each type of account in every branch */
SELECT Branch, AccountType, COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM finance_dataset
GROUP BY Branch, AccountType
ORDER BY Branch, AccountType;

-- How many accounts exist per branch?
select Branch, count(*) as TotalCount
	from finance_dataset
    group by Branch;
    
-- Which branch has the highest total deposits?
select Branch, Round(sum(Amount),2) as TotalDeposits
		from finance_dataset
group by branch
order by TotalDeposits desc
Limit 1;   

-- What is the average balance per account type?  
Select AccountType, floor(AVG(Amount)) as AvgBalance
	From finance_dataset
 group by AccountType
 order by AvgBalance Desc;
 
 -- Who are the top 10 customers by balance?
 Select CustomerID, Branch, Amount as Balance
	from finance_dataset
	ORDER BY Balance desc
	limit 10;
    
-- How many new accounts were opened each year?    
SELECT AccountType,YEAR(Date) AS YearOpened, COUNT(*) AS AccountsOpened
FROM finance_dataset
GROUP BY YEAR(Date);
   
-- Most common transaction type per branch
SELECT Branch, TransactionType, COUNT(*) AS TxnCount
FROM finance_dataset
GROUP BY Branch, TransactionType
ORDER BY Branch, TxnCount DESC;

-- Monthly transaction volume (count & sum)
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
       COUNT(*) AS TotalTransactions,
       SUM(Amount) AS TotalAmount
FROM finance_dataset
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Month;

-- Customers who did both Deposit and Withdrawal
SELECT CustomerID
FROM finance_dataset
WHERE TransactionType IN ('Deposit','Withdrawal')
GROUP BY CustomerID
HAVING COUNT(DISTINCT TransactionType) = 2;

-- Branch with the highest number of transfers
SELECT Branch, COUNT(*) AS TransferCount
FROM finance_dataset
WHERE TransactionType = 'Transfer'
GROUP BY Branch
ORDER BY TransferCount DESC
LIMIT 1;

-- Highest single transaction per branch
SELECT Branch, MAX(Amount) AS MaxTransaction
FROM finance_dataset
GROUP BY Branch;

-- Currency-wise total transaction amount
SELECT Currency, SUM(Amount) AS TotalAmount
FROM finance_dataset
GROUP BY Currency
ORDER BY TotalAmount DESC;





