# T1D Genetic Risk Score (T1GRS) Analysis - CatBoost

A Docker-based pipeline for calculating Type 1 Diabetes genetic risk scores using CatBoost machine learning models. This tool processes VCF files and generates risk probabilities based on genetic variants.

## Overview

This containerized pipeline implements a comprehensive genetic risk scoring system for Type 1 Diabetes (T1D) using:
- **CatBoost machine learning models** for risk prediction
- **Multi-model approach**: All variants, HLA-only, and non-HLA models
- **Percentile-based risk assessment** 
- **VCF file processing** for genetic variant analysis

## 🔒 Access Requirements

**This tool uses a PRIVATE Docker image** containing proprietary models and reference data. 

### 🚨 To Request Access:
- **Contact**: [kgaulton@health.ucsd.edu]
- **Include**: Your Docker Hub username and intended use case
- **Access**: Will be granted for approved research collaborations

### 📋 What You'll Need:
1. Docker Hub account
2. Approval from the research team
3. Institutional affiliation for research use

## 🚀 Quick Start (For Authorized Users)

### Prerequisites
- Docker installed on your system
- Docker Hub account with granted access to private repository
- Access approval from the research team

### Installation & Testing

```bash
# Step 1: Login to Docker Hub (required for private repository)
docker login
# Enter your Docker Hub username and password

# Step 2: Pull the private image
docker pull kgaultonlab/t1d-grs-analysis-r3-catboost:latest

# Step 3: Test with included sample data
mkdir -p ./test_output && chmod 777 ./test_output

docker run --rm \
  -v ./test_output:/output \
  kgaultonlab/t1d-grs-analysis-r3-catboost:latest \
  --vcf_path /data/test_data/T1GRS_test_data.vcf \
  --r3_variants_path /data/test_data/T1GRS_allele_order.txt \
  --r2_snps_path /data/test_data/ALL5_199_TOPMED_SUSIE_HLA_T1D_signals_updateID_r3.vcf.alleles \
  --allele_order_path /data/test_data/ALL5_199_TOPMED_SUSIE_HLA_T1D_signals_updateID.vcf.alleles \
  --catboost_all_model_path /data/test_data/ALL_No_PCS_catboost.ubj \
  --catboost_nohla_model_path /data/test_data/NonHLA_No_PCS_catboost.ubj \
  --catboost_hlaonly_model_path /data/test_data/HLA_No_PCS_catboost.ubj \
  --all_columns_path /data/test_data/ALL_columns.txt \
  --hla_columns_path /data/test_data/HLA_columns.txt \
  --nonhla_columns_path /data/test_data/nonHLA_columns.txt \
  --total_percentiles_path /data/test_data/T1GRS_total_percentile_risk.txt \
  --mhc_percentiles_path /data/test_data/T1GRS_MHC_percentile_risk.txt \
  --nonmhc_percentiles_path /data/test_data/T1GRS_nonMHC_percentile_risk.txt \
  --output_path /output/test_results.csv

# Step 4: Check results
cat ./test_output/test_results.csv
```

### Using Your Own VCF Data

```bash
# Run analysis with your VCF file
docker run --rm \
  -v /path/to/your/data:/input \
  -v ./results:/output \
  kgaultonlab/t1d-grs-analysis-r3-catboost:latest \
  --vcf_path /input/your_variants.vcf \
  --r3_variants_path /data/test_data/T1GRS_allele_order.txt \
  --r2_snps_path /data/test_data/ALL5_199_TOPMED_SUSIE_HLA_T1D_signals_updateID_r3.vcf.alleles \
  --allele_order_path /data/test_data/ALL5_199_TOPMED_SUSIE_HLA_T1D_signals_updateID.vcf.alleles \
  --catboost_all_model_path /data/test_data/ALL_No_PCS_catboost.ubj \
  --catboost_nohla_model_path /data/test_data/NonHLA_No_PCS_catboost.ubj \
  --catboost_hlaonly_model_path /data/test_data/HLA_No_PCS_catboost.ubj \
  --all_columns_path /data/test_data/ALL_columns.txt \
  --hla_columns_path /data/test_data/HLA_columns.txt \
  --nonhla_columns_path /data/test_data/nonHLA_columns.txt \
  --total_percentiles_path /data/test_data/T1GRS_total_percentile_risk.txt \
  --mhc_percentiles_path /data/test_data/T1GRS_MHC_percentile_risk.txt \
  --nonmhc_percentiles_path /data/test_data/T1GRS_nonMHC_percentile_risk.txt \
  --output_path /output/your_results.csv
```

## 📋 Command Line Arguments

| Argument | Description | Required |
|----------|-------------|----------|
| `--vcf_path` | Path to input VCF file | ✅ |
| `--r3_variants_path` | Path to R3 variants file | ✅ |
| `--r2_snps_path` | Path to R2 SNPs file | ✅ |
| `--allele_order_path` | Path to allele order file | ✅ |
| `--catboost_all_model_path` | Path to all-variants CatBoost model | ✅ |
| `--catboost_nohla_model_path` | Path to non-HLA CatBoost model | ✅ |
| `--catboost_hlaonly_model_path` | Path to HLA-only CatBoost model | ✅ |
| `--all_columns_path` | Path to all columns definition | ✅ |
| `--hla_columns_path` | Path to HLA columns definition | ✅ |
| `--nonhla_columns_path` | Path to non-HLA columns definition | ✅ |
| `--total_percentiles_path` | Path to total percentiles file | ✅ |
| `--mhc_percentiles_path` | Path to MHC percentiles file | ✅ |
| `--nonmhc_percentiles_path` | Path to non-MHC percentiles file | ✅ |
| `--output_path` | Path for output CSV file | ✅ |

## 🧬 What's Included in the Private Docker Image

The Docker image contains everything needed for analysis:

### ✅ Pre-trained Models
- All-variants CatBoost model
- HLA-only CatBoost model  
- Non-HLA CatBoost model

### ✅ Reference Data
- Variant reference files
- Allele order definitions
- Percentile lookup tables
- Test VCF data for validation

### ✅ Runtime Environment
- Python 3.8 with all dependencies
- Optimized for genetic analysis workflows

## 📊 Output

The pipeline generates CSV files containing:
- Sample identifiers
- Risk probabilities from each model (All, HLA-only, Non-HLA)
- Percentile scores
- Combined risk assessments


## 🏗️ Building from Source

If you have access to the reference data and models, you can build the Docker image locally:

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/t1d-grs-analysis-r3-catboost.git
cd t1d-grs-analysis-r3-catboost

# Add your data files to test_data/ directory
# (models, reference files, test VCF - not included in this public repo)

# Build the Docker image
docker build -t your-registry/t1d-grs-analysis:latest .
```

## 🛠️ Technical Details

### Dependencies
- Python 3.8.10
- NumPy, Pandas, CatBoost, Scikit-learn

### System Requirements  
- Docker installed
- 4GB+ RAM recommended
- Sufficient storage for VCF files

## 🐛 Troubleshooting

### Common Issues

**Access Denied**
```bash
# Ensure you're logged in and have access
docker login
# Contact research team if access issues persist
```

**Permission Issues with Output**
```bash
# Create output directory with write permissions
mkdir -p ./results && chmod 777 ./results
```

**Memory Issues**
```bash
# Increase Docker memory limit or use smaller VCF files
docker run --memory=4g [other arguments...]
```

## 📝 Citation

If you use this tool in your research, please cite:


## 🤝 Collaboration & Support

- **Research Inquiries**: [kgaulton@health.ucsd.edu]
- **Issues**: Report technical issues in this GitHub repository
- **Access Requests**: Contact the research team directly

## 📄 License

Copyright Notice
This software is Copyright © 2024 The Regents of the University of California. All Rights Reserved. Permission to copy, modify, and distribute this software and its documentation for educational, research and non-profit purposes, without fee, and without a written agreement is hereby granted, provided that the above copyright notice, this paragraph and the following three paragraphs appear in all copies. Permission to make commercial use of this software may be obtained by contacting:
Office of Innovation and Commercialization
9500 Gilman Drive, Mail Code 0910
University of California
La Jolla, CA 92093-0910
innovation@ucsd.edu

This software program and documentation are copyrighted by The Regents of the University of California. The software program and documentation are supplied “as is”, without any accompanying services from The Regents. The Regents does not warrant that the operation of the program will be uninterrupted or error-free. The end-user understands that the program was developed for research purposes and is advised not to rely exclusively on the program for any reason.
IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON AN “AS IS” BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.


