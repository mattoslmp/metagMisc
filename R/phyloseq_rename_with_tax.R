
#' @title Rename phyloseq OTUs or species with taxonomy ranks.
#'
#' @param physeq A phyloseq-class object
#' @param taxrank Character, which taxonomy rank to use for renaming
#'
#' @return A phyloseq-class object with renamed OTUs.
#' @export
#'
#' @examples
#' # Load data
#' data("GlobalPatterns")
#'
#' # Agglomerate taxa of the same phylum
#' GP <- tax_glom(GlobalPatterns, taxrank="Phylum")
#' taxa_names(GP)
#'
#' # Assign phylum name to the agglomerated taxa
#' GP <- phyloseq_rename_with_tax(GP, taxrank="Phylum")
#' taxa_names(GP)
#'
phyloseq_rename_with_tax <- function(physeq, taxrank = "Family"){

  ## Extract taxonomy table
  txx <- as.data.frame(phyloseq::tax_table(physeq), stringsAsFactors = F)

  ## Check if
  if(!taxrank %in% colnames(txx)){
    stop(taxrank, " is not in columns of tax_table.\n")
  }

  ## Extract new names from tax table
  newnames <- txx[, taxrank]

  ## Check for the uniqueness of taxa names
  if(nrow(txx) != length(unique(newnames))){
    stop("Taxonomy column should contain only unique names.\n")
  }

  ## Rename taxa
  # taxa_names(physeq) <- newnames[ match(x = taxa_names(physeq), table = rownames(txx)) ]  # reorder names
  phyloseq::taxa_names(physeq) <- newnames   # names should be in the same order

  return(physeq)
}
