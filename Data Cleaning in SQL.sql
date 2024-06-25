--Cleasing Data in SQL Queries
select*
from PortfolioProjects..NashvilleHousing


-----------------------------------------------------

--Standardize Date Format 


select SaleDate, convert(date, saledate) 
--saledate have time so just separate it
from PortfolioProjects..NashvilleHousing

alter table NashvilleHousing --use when we add new column
add SaledateConverted Date;

update NashvilleHousing
set SaledateConverted = CONVERT(date, Saledate);

select SaledateConverted
from PortfolioProjects..NashvilleHousing


-------------------------------------------------

--Populate Property Address data 
--because some propertyAddress been null despite of same parceid, so we have to fill null


select  *
from PortfolioProjects..NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select  a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProjects..NashvilleHousing a
JOIN PortfolioProjects..NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

UPDATE a      --do not need "alter table" cz just update null without adding column
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProjects..NashvilleHousing a
JOIN PortfolioProjects..NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


----------------------------------------------

--Breaking out Address into Individual Columns (Address, City, State)
--in propertyaddress has no delimiter, just have comma between city state or smt.
--so we're gonna to be separating this one out 2 columns and get rid off comma

--1/The PropertyAdress
select PropertyAddress
from PortfolioProjects..NashvilleHousing

select 
SUBSTRING (PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as Address
from PortfolioProjects..NashvilleHousing
--comma is 0, so have to -1 to take just info before comma. LEN is the another of address

alter table NashvilleHousing
add PropertySplitAdress Nvarchar(255);
update NashvilleHousing
set PropertySplitAdress = SUBSTRING (PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1);

alter table NashvilleHousing
add PropertySplitCity Nvarchar(255);
update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress));

select*
from PortfolioProjects..NashvilleHousing

--2/ The OwnerAddess

select 
PARSENAME(replace(OwnerAddress,',','.'),3)
,PARSENAME(replace(OwnerAddress,',','.'),2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
from PortfolioProjects..NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress Nvarchar(255);
update NashvilleHousing
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3);

alter table NashvilleHousing
add OwnerSplitCity Nvarchar(255);
update NashvilleHousing
set OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'),2);

alter table NashvilleHousing
add OwnerSplitState Nvarchar(255);
update NashvilleHousing
set OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1);


--------------------------------------------------------------


--Change Y and N to Yes and No in "SoldAsVacant" field

select distinct SoldAsVacant, count(SoldAsVacant)
from PortfolioProjects..NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant ='Y' then 'Yes'
	@when SoldAsVacant ='N' then 'No'
	  else SoldAsVacant
	  end
from PortfolioProjects..NashvilleHousing

update NashvilleHousing
set SoldAsVacant= case when SoldAsVacant ='Y' then 'Yes'
	@when SoldAsVacant ='N' then 'No'
	  else SoldAsVacant
	  end


----------------------------------------------------

-- Remove Duplicates

with RowNumCTE as(
select *,
	ROW_NUMBER() over (
	partition by parcelid,
				 PropertyAddress,
				 SalePrice,
				 LegalReference
				 order by
					uniqueID
					) row_num
from PortfolioProjects..NashvilleHousing
			)
	delete
	from RowNumCTE
	 where row_num>1


----------------------------------------------------

--Delete Unused Columns

select*
from PortfolioProjects..NashvilleHousing

alter table PortfolioProjects..NashvilleHousing
drop column saledate, propertyaddress,owneraddress, taxdistrict