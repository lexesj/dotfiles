#!/bin/bash

# manage_block target_file content [marker_begin] [marker_end]
manage_block() {
	local target_file="$1"
	local content="$2"
	local marker_begin="${3:-# BEGIN CHEZMOI MANAGED BLOCK}"
	local marker_end="${4:-# END CHEZMOI MANAGED BLOCK}"

	# Ensure target file exists
	touch "$target_file"

	local full_block="$marker_begin
$content
$marker_end"

	# Export variables for perl to use
	export MARKER_BEGIN="$marker_begin"
	export MARKER_END="$marker_end"
	export FULL_BLOCK="$full_block"

	if grep -q "$marker_begin" "$target_file"; then
		echo "Updating existing chezmoi block in $target_file..."
		# Replace everything between the markers, including the markers themselves
		# Using perl substr to avoid regex interpolation in the replacement string
		perl -i -0777 -pe '
			BEGIN {
				$block = $ENV{FULL_BLOCK};
				$begin = $ENV{MARKER_BEGIN};
				$end = $ENV{MARKER_END};
			}
			$start = index($_, $begin);
			if ($start != -1) {
				$finish = index($_, $end, $start);
				if ($finish != -1) {
					$finish += length($end);
					substr($_, $start, $finish - $start) = $block;
				}
			}
		' "$target_file"
	else
		echo "Appending new chezmoi block to $target_file..."
		# Append the block to the end of the file
		{
			echo ""
			echo "$full_block"
		} >> "$target_file"
	fi

	chmod 644 "$target_file"
}
