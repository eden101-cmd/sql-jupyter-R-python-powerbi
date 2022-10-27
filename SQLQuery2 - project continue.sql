--cleaning data in sql queries:
--select * from 
--PortfolioProject.dbo.NashvilleHousing

-- standrize date format:

--select saleDate,convert(Date,saleDate) from 
--PortfolioProject.dbo.NashvilleHousing;


--update PortfolioProject.dbo.NashvilleHousing
--set SaleDate = convert(Date,SaleDate);

--checking:
--select SaleDate from PortfolioProject.dbo.NashvilleHousing

 -- If it doesn't Update properly
--alter table PortfolioProject.dbo.NashvilleHousing
--add sale_date_converted date ;


--update PortfolioProject.dbo.NashvilleHousing
--set sale_date_converted = convert(Date,SaleDate);

--select sale_date_converted from PortfolioProject.dbo.NashvilleHousing -> after this it works !

-- Populate Property Address data

--Select *
--From PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID
-- by checking this way we will see that we have more than one preson with the same info,so we need to delte him.

-- <> -> not equal !

--Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) --> it means if the property in a is null then insert instead of the null the b address
--From PortfolioProject.dbo.NashvilleHousing a
--JOIN PortfolioProject.dbo.NashvilleHousing b
--	on a.ParcelID = b.ParcelID
--	AND a.[UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress is null

--Update a
--SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
--From PortfolioProject.dbo.NashvilleHousing a
--JOIN PortfolioProject.dbo.NashvilleHousing b
--	on a.ParcelID = b.ParcelID
--	AND a.[UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress is null

-- for checking: 
--select  ParcelID, PropertyAddress, ParcelID from PortfolioProject.dbo.NashvilleHousing

-- Breaking out Address into Individual Columns (Address, City, State)
--Select PropertyAddress
--From PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

-- substring : SUBSTRING(string, start, length)
-- CHARINDEX will give us or after the delimiter of before if we will use the -1 
-- we will get the before and if we will use the +1 we will get the after.
--SELECT
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
--, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

--From PortfolioProject.dbo.NashvilleHousing

--ALTER TABLE NashvilleHousing
--Add PropertySplitAddress Nvarchar(255);

--Update NashvilleHousing
--SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


--ALTER TABLE NashvilleHousing
--Add PropertySplitCity Nvarchar(255);

--Update NashvilleHousing
--SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

--Select *
--From PortfolioProject.dbo.NashvilleHousing

--Select OwnerAddress
--From PortfolioProject.dbo.NashvilleHousing

-- using parsename: the parsename only usefull with period.(".") 
--then we will replace the commas with periods.
-- it goes backwards !! 
-- super easy for using delimiters

--Select
--PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
--,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
--,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
--From PortfolioProject.dbo.NashvilleHousing

--ALTER TABLE NashvilleHousing
--Add OwnerSplitAddress Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


--ALTER TABLE NashvilleHousing
--Add OwnerSplitCity Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



--ALTER TABLE NashvilleHousing
--Add OwnerSplitState Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



--Select *
--From PortfolioProject.dbo.NashvilleHousing


-- Change Y and N to Yes and No in "Sold as Vacant" field

--select Distinct(SoldAsVacant), Count(SoldAsVacant)
--From PortfolioProject.dbo.NashvilleHousing
--Group by SoldAsVacant
--order by 2

--Select SoldAsVacant
--, CASE When SoldAsVacant = 'Y' THEN 'Yes'
--	   When SoldAsVacant = 'N' THEN 'No'
--	   ELSE SoldAsVacant
--	   END
--From PortfolioProject.dbo.NashvilleHousing

--Update NashvilleHousing
--SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
--	   When SoldAsVacant = 'N' THEN 'No'
--	   ELSE SoldAsVacant
--	   END


-- Remove Duplicates:

--WITH RowNumCTE AS(
--Select *,
--	ROW_NUMBER() OVER ( -- row number is counting every uniqe row -> meaning if we will have the same 2 rows 
--	PARTITION BY ParcelID,
--				 PropertyAddress,
--				 SalePrice,
--				 SaleDate,
--				 LegalReference
--				 ORDER BY
--					UniqueID
--					) as row_num
--From PortfolioProject.dbo.NashvilleHousing
----order by ParcelID
--)
--Select *
--From RowNumCTE
--Where row_num > 1
--Order by PropertyAddress;

-- in this way we will see how much duplicate rows we have
-- then now we woll want to delete them.
-- then we need to do the same query but in delte way

--WITH RowNumCTE AS(
--Select *,
--	ROW_NUMBER() OVER ( -- row number is counting every uniqe row -> meaning if we will have the same 2 rows 
--	PARTITION BY ParcelID,
--				 PropertyAddress,
--				 SalePrice,
--				 SaleDate,
--				 LegalReference
--				 ORDER BY
--					UniqueID
--					) as row_num
--From PortfolioProject.dbo.NashvilleHousing
----order by ParcelID
--)
--delete
--From RowNumCTE
--Where row_num > 1
----Order by PropertyAddress;

-- Delete Unused Columns

--Select *
--From PortfolioProject.dbo.NashvilleHousing

--ALTER TABLE PortfolioProject.dbo.NashvilleHousing
--DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

