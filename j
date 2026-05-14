<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Calculator</title>
    <style>
        :root {
            --bg: #f0f4f8;
            --card-bg: #ffffff;
            --text: #1a202c;
            --text-secondary: #4a5568;
            --text-muted: #718096;
            --accent: #4f6ef7;
            --accent-hover: #3b54db;
            --accent-light: #eef1fe;
            --danger: #e53e3e;
            --danger-light: #fff5f5;
            --success: #38a169;
            --warning: #d69e2e;
            --border: #e2e8f0;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08), 0 2px 4px rgba(0, 0, 0, 0.04);
            --shadow-lg: 0 10px 30px rgba(0, 0, 0, 0.1), 0 4px 8px rgba(0, 0, 0, 0.05);
            --radius-sm: 8px;
            --radius: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;
            --transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            -webkit-tap-highlight-color: transparent;
            user-select: none;
            -webkit-user-select: none;
        }

        .container {
            width: 100%;
            max-width: 680px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Average Display */
        .average-card {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 24px 28px;
            box-shadow: var(--shadow-md);
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: var(--transition);
        }
        .average-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            border-radius: 4px 4px 0 0;
            transition: background 0.4s ease;
        }
        .average-card.grade-high::before {
            background: #38a169;
        }
        .average-card.grade-mid::before {
            background: #d69e2e;
        }
        .average-card.grade-low::before {
            background: #e53e3e;
        }
        .average-card.grade-none::before {
            background: #cbd5e0;
        }
        .average-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
            font-weight: 600;
            margin-bottom: 4px;
        }
        .average-value {
            font-size: 4rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            line-height: 1;
            transition: color 0.4s ease;
        }
        .grade-high .average-value {
            color: #38a169;
        }
        .grade-mid .average-value {
            color: #d69e2e;
        }
        .grade-low .average-value {
            color: #e53e3e;
        }
        .grade-none .average-value {
            color: #a0aec0;
        }
        .average-subtitle {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 4px;
            font-weight: 500;
        }

        /* Toggles Row */
        .toggles-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        .toggle-card {
            flex: 1;
            min-width: 180px;
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 16px 18px;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            transition: var(--transition);
            cursor: pointer;
            border: 2px solid transparent;
        }
        .toggle-card:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--border);
        }
        .toggle-card.active-toggle {
            border-color: var(--accent);
            background: var(--accent-light);
        }
        .toggle-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .toggle-title {
            font-weight: 700;
            font-size: 0.9rem;
            color: var(--text);
            letter-spacing: -0.01em;
        }
        .toggle-subtitle {
            font-size: 0.75rem;
            color: var(--text-muted);
            font-weight: 500;
        }
        /* Toggle Switch */
        .toggle-switch {
            position: relative;
            width: 50px;
            height: 28px;
            flex-shrink: 0;
            background: #cbd5e0;
            border-radius: 28px;
            transition: background 0.3s ease;
            cursor: pointer;
        }
        .toggle-switch.active {
            background: var(--accent);
        }
        .toggle-switch::after {
            content: '';
            position: absolute;
            top: 3px;
            left: 3px;
            width: 22px;
            height: 22px;
            background: #fff;
            border-radius: 50%;
            transition: transform 0.3s ease;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        }
        .toggle-switch.active::after {
            transform: translateX(22px);
        }

        /* Exams Container */
        .exams-container {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 8px 6px;
            box-shadow: var(--shadow-md);
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .exam-row {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            border-radius: var(--radius-sm);
            transition: var(--transition);
            flex-wrap: wrap;
            min-height: 54px;
        }
        .exam-row:hover {
            background: #f7fafc;
        }
        .exam-row.final-row {
            transition: opacity 0.35s ease, background 0.2s ease;
        }
        .exam-row.final-row.disabled-final {
            opacity: 0.4;
            pointer-events: none;
            background: #fafafa;
            border-radius: var(--radius-sm);
        }
        .exam-row.final-row.disabled-final .slider {
            opacity: 0.5;
        }
        .exam-info {
            display: flex;
            align-items: baseline;
            gap: 6px;
            min-width: 140px;
            flex-shrink: 0;
        }
        .exam-name {
            font-weight: 700;
            font-size: 0.9rem;
            color: var(--text);
            letter-spacing: -0.01em;
        }
        .exam-weight {
            font-size: 0.75rem;
            color: var(--text-muted);
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .exam-weight.changed {
            animation: weightPulse 0.5s ease;
        }
        @keyframes weightPulse {
            0%,
            100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.15);
                color: var(--accent);
            }
        }
        .btn-adjust {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 2px solid var(--border);
            background: #fff;
            cursor: pointer;
            font-size: 1.2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            flex-shrink: 0;
            color: var(--text-secondary);
            line-height: 1;
            padding: 0;
        }
        .btn-adjust:hover {
            background: var(--accent-light);
            border-color: var(--accent);
            color: var(--accent);
            box-shadow: 0 2px 8px rgba(79, 110, 247, 0.2);
        }
        .btn-adjust:active {
            transform: scale(0.92);
            background: var(--accent);
            color: #fff;
            border-color: var(--accent);
        }
        .slider {
            flex: 1;
            min-width: 100px;
            -webkit-appearance: none;
            appearance: none;
            height: 8px;
            border-radius: 8px;
            background: #e2e8f0;
            outline: none;
            cursor: pointer;
            transition: background 0.15s ease;
        }
        .slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: #fff;
            border: 3px solid var(--accent);
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
            transition: var(--transition);
        }
        .slider::-webkit-slider-thumb:hover {
            border-color: var(--accent-hover);
            box-shadow: 0 4px 14px rgba(79, 110, 247, 0.3);
            transform: scale(1.05);
        }
        .slider::-webkit-slider-thumb:active {
            transform: scale(1.1);
            border-color: var(--accent-hover);
            box-shadow: 0 6px 18px rgba(79, 110, 247, 0.35);
        }
        .slider::-moz-range-thumb {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: #fff;
            border: 3px solid var(--accent);
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
        }
        .score-display {
            font-weight: 700;
            font-size: 1.05rem;
            min-width: 44px;
            text-align: right;
            color: var(--text);
            letter-spacing: -0.01em;
            transition: color 0.15s ease;
            flex-shrink: 0;
        }
        .score-display.updated {
            animation: scoreFlash 0.35s ease;
        }
        @keyframes scoreFlash {
            0%,
            100% {
                color: var(--text);
            }
            50% {
                color: var(--accent);
                transform: scale(1.1);
            }
        }

        /* Divider */
        .divider {
            height: 1px;
            background: var(--border);
            margin: 2px 10px;
            opacity: 0.7;
        }

        /* Final badge */
        .final-badge {
            display: inline-block;
            font-size: 0.65rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            padding: 2px 8px;
            border-radius: 20px;
            background: #fff3cd;
            color: #b7791f;
            margin-left: 4px;
            transition: var(--transition);
        }
        .disabled-final .final-badge {
            background: #e2e8f0;
            color: #a0aec0;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .container {
                gap: 14px;
            }
            .average-value {
                font-size: 3rem;
            }
            .average-card {
                padding: 18px 16px;
            }
            .exam-row {
                gap: 6px;
                padding: 8px 10px;
            }
            .exam-info {
                min-width: 110px;
                gap: 4px;
            }
            .exam-name {
                font-size: 0.8rem;
            }
            .exam-weight {
                font-size: 0.7rem;
            }
            .btn-adjust {
                width: 28px;
                height: 28px;
                font-size: 1rem;
            }
            .slider {
                min-width: 60px;
                height: 6px;
            }
            .slider::-webkit-slider-thumb {
                width: 24px;
                height: 24px;
                border-width: 2px;
            }
            .score-display {
                font-size: 0.9rem;
                min-width: 34px;
            }
            .toggle-card {
                padding: 12px 14px;
                min-width: 140px;
            }
            .toggle-title {
                font-size: 0.8rem;
            }
            .toggle-subtitle {
                font-size: 0.7rem;
            }
            .toggle-switch {
                width: 42px;
                height: 24px;
            }
            .toggle-switch::after {
                width: 18px;
                height: 18px;
                top: 3px;
                left: 3px;
            }
            .toggle-switch.active::after {
                transform: translateX(18px);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Average Display -->
        <div class="average-card grade-none" id="averageCard">
            <div class="average-label">Weighted Average</div>
            <div class="average-value" id="averageValue">0</div>
            <div class="average-subtitle" id="averageSubtitle">Total weight: 112</div>
        </div>

        <!-- Toggles -->
        <div class="toggles-row">
            <div class="toggle-card" id="weightToggleCard" tabindex="0" role="button" aria-pressed="false">
                <div class="toggle-info">
                    <span class="toggle-title">Alternative Weights</span>
                    <span class="toggle-subtitle" id="weightToggleLabel">Using Standard Set</span>
                </div>
                <div class="toggle-switch" id="weightToggleSwitch"></div>
            </div>
            <div class="toggle-card active-toggle" id="finalToggleCard" tabindex="0" role="button" aria-pressed="true">
                <div class="toggle-info">
                    <span class="toggle-title">Include Final Exam</span>
                    <span class="toggle-subtitle" id="finalToggleLabel">Final is enabled</span>
                </div>
                <div class="toggle-switch active" id="finalToggleSwitch"></div>
            </div>
        </div>

        <!-- Exams -->
        <div class="exams-container" id="examsContainer">
            <!-- Generated by JavaScript -->
        </div>
    </div>

    <script>
        (function() {
            // ──────────────────────────────────────
            // Configuration
            // ──────────────────────────────────────
            const weightSets = {
                standard: {
                    name: 'Standard',
                    exams: [11, 9, 9, 8, 11, 8],
                    final: 56,
                    label: 'Using Standard Set',
                },
                alternative: {
                    name: 'Alternative',
                    exams: [96, 105, 96, 74, 114, 95],
                    final: 580,
                    label: 'Using Alternative Set',
                },
            };

            const examLabels = [
                'Exam 1', 'Exam 2', 'Exam 3',
                'Exam 4', 'Exam 5', 'Exam 6',
            ];

            // ──────────────────────────────────────
            // State
            // ──────────────────────────────────────
            let currentWeightSet = 'standard'; // 'standard' | 'alternative'
            let finalEnabled = true;
            const scores = new Array(7).fill(0); // indices 0-5: exams, 6: final

            // ──────────────────────────────────────
            // DOM References
            // ──────────────────────────────────────
            const averageCard = document.getElementById('averageCard');
            const averageValue = document.getElementById('averageValue');
            const averageSubtitle = document.getElementById('averageSubtitle');
            const examsContainer = document.getElementById('examsContainer');

            const weightToggleCard = document.getElementById('weightToggleCard');
            const weightToggleSwitch = document.getElementById('weightToggleSwitch');
            const weightToggleLabel = document.getElementById('weightToggleLabel');

            const finalToggleCard = document.getElementById('finalToggleCard');
            const finalToggleSwitch = document.getElementById('finalToggleSwitch');
            const finalToggleLabel = document.getElementById('finalToggleLabel');

            // Dynamic element references
            let examRows = [];
            let sliders = [];
            let scoreDisplays = [];
            let weightSpans = [];
            let minusButtons = [];
            let plusButtons = [];
            let finalRow = null;

            // ──────────────────────────────────────
            // Helper: Format score for display
            // ──────────────────────────────────────
            function formatScore(value) {
                if (value === Math.floor(value)) {
                    return value.toString();
                }
                return value.toFixed(1);
            }

            // ──────────────────────────────────────
            // Helper: Get current weights
            // ──────────────────────────────────────
            function getCurrentWeights() {
                const set = weightSets[currentWeightSet];
                return {
                    exams: [...set.exams],
                    final: set.final,
                    totalExamsOnly: set.exams.reduce((a, b) => a + b, 0),
                    totalAll: set.exams.reduce((a, b) => a + b, 0) + set.final,
                };
            }

            // ──────────────────────────────────────
            // Calculate and display average
            // ──────────────────────────────────────
            function updateAverage() {
                const weights = getCurrentWeights();
                let weightedSum = 0;
                let totalWeight = 0;

                // Always include exams 0-5
                for (let i = 0; i < 6; i++) {
                    weightedSum += scores[i] * weights.exams[i];
                    totalWeight += weights.exams[i];
                }

                // Include final if enabled
                if (finalEnabled) {
                    weightedSum += scores[6] * weights.final;
                    totalWeight += weights.final;
                }

                const avg = totalWeight > 0 ? weightedSum / totalWeight : 0;

                // Update display
                averageValue.textContent = formatScore(Math.round(avg * 10) / 10);

                // Update subtitle
                averageSubtitle.textContent = `Total weight: ${totalWeight}`;

                // Update card color class
                averageCard.classList.remove('grade-high', 'grade-mid', 'grade-low', 'grade-none');
                if (avg === 0 && totalWeight === 0) {
                    averageCard.classList.add('grade-none');
                } else if (avg >= 80) {
                    averageCard.classList.add('grade-high');
                } else if (avg >= 60) {
                    averageCard.classList.add('grade-mid');
                } else if (avg > 0) {
                    averageCard.classList.add('grade-low');
                } else {
                    averageCard.classList.add('grade-none');
                }
            }

            // ──────────────────────────────────────
            // Update weight labels on all rows
            // ──────────────────────────────────────
            function updateWeightLabels() {
                const weights = getCurrentWeights();
                for (let i = 0; i < 6; i++) {
                    if (weightSpans[i]) {
                        weightSpans[i].textContent = `(weight: ${weights.exams[i]})`;
                        // Trigger pulse animation
                        weightSpans[i].classList.remove('changed');
                        void weightSpans[i].offsetWidth;
                        weightSpans[i].classList.add('changed');
                    }
                }
                // Update final weight label
                const finalWeightSpan = document.getElementById('finalWeightSpan');
                if (finalWeightSpan) {
                    finalWeightSpan.textContent = `(weight: ${weights.final})`;
                    finalWeightSpan.classList.remove('changed');
                    void finalWeightSpan.offsetWidth;
                    finalWeightSpan.classList.add('changed');
                }
                updateAverage();
            }

            // ──────────────────────────────────────
            // Update final row visibility/state
            // ──────────────────────────────────────
            function updateFinalRowState() {
                if (!finalRow) return;
                if (finalEnabled) {
                    finalRow.classList.remove('disabled-final');
                } else {
                    finalRow.classList.add('disabled-final');
                }
                // Update toggle UI
                if (finalEnabled) {
                    finalToggleCard.classList.add('active-toggle');
                    finalToggleSwitch.classList.add('active');
                    finalToggleLabel.textContent = 'Final is enabled';
                    finalToggleCard.setAttribute('aria-pressed', 'true');
                } else {
                    finalToggleCard.classList.remove('active-toggle');
                    finalToggleSwitch.classList.remove('active');
                    finalToggleLabel.textContent = 'Final is disabled';
                    finalToggleCard.setAttribute('aria-pressed', 'false');
                }
                updateAverage();
            }

            // ──────────────────────────────────────
            // Handle slider change
            // ──────────────────────────────────────
            function handleSliderChange(index) {
                const value = parseFloat(sliders[index].value);
                scores[index] = value;
                if (scoreDisplays[index]) {
                    scoreDisplays[index].textContent = formatScore(value);
                    // Flash animation
                    scoreDisplays[index].classList.remove('updated');
                    void scoreDisplays[index].offsetWidth;
                    scoreDisplays[index].classList.add('updated');
                }
                updateAverage();
            }

            // ──────────────────────────────────────
            // Handle button click (adjust by delta)
            // ──────────────────────────────────────
            function handleButtonClick(index, delta) {
                // If final is disabled and this is the final row, ignore
                if (index === 6 && !finalEnabled) return;

                let newValue = scores[index] + delta;
                // Clamp to 0-100, rounded to nearest 0.5
                newValue = Math.max(0, Math.min(100, newValue));
                newValue = Math.round(newValue * 2) / 2;

                scores[index] = newValue;
                if (sliders[index]) {
                    sliders[index].value = newValue;
                }
                if (scoreDisplays[index]) {
                    scoreDisplays[index].textContent = formatScore(newValue);
                    scoreDisplays[index].classList.remove('updated');
                    void scoreDisplays[index].offsetWidth;
                    scoreDisplays[index].classList.add('updated');
                }
                updateAverage();
            }

            // ──────────────────────────────────────
            // Build exam rows
            // ──────────────────────────────────────
            function buildExamRows() {
                examsContainer.innerHTML = '';
                examRows = [];
                sliders = [];
                scoreDisplays = [];
                weightSpans = [];
                minusButtons = [];
                plusButtons = [];
                finalRow = null;

                const weights = getCurrentWeights();

                // Create 6 exam rows
                for (let i = 0; i < 6; i++) {
                    const row = document.createElement('div');
                    row.className = 'exam-row';
                    row.setAttribute('data-index', i);

                    // Exam info
                    const info = document.createElement('div');
                    info.className = 'exam-info';
                    const nameSpan = document.createElement('span');
                    nameSpan.className = 'exam-name';
                    nameSpan.textContent = examLabels[i];
                    const weightSpan = document.createElement('span');
                    weightSpan.className = 'exam-weight';
                    weightSpan.textContent = `(weight: ${weights.exams[i]})`;
                    info.appendChild(nameSpan);
                    info.appendChild(weightSpan);
                    weightSpans.push(weightSpan);

                    // Minus button
                    const btnMinus = document.createElement('button');
                    btnMinus.className = 'btn-adjust';
                    btnMinus.textContent = '−';
                    btnMinus.setAttribute('aria-label', `Decrease ${examLabels[i]} score by 0.5`);
                    btnMinus.addEventListener('click', (e) => {
                        e.preventDefault();
                        handleButtonClick(i, -0.5);
                    });

                    // Slider
                    const slider = document.createElement('input');
                    slider.type = 'range';
                    slider.className = 'slider';
                    slider.min = '0';
                    slider.max = '100';
                    slider.step = '0.5';
                    slider.value = scores[i];
                    slider.setAttribute('aria-label', `${examLabels[i]} score`);
                    slider.addEventListener('input', () => handleSliderChange(i));
                    slider.addEventListener('change', () => handleSliderChange(i));

                    // Plus button
                    const btnPlus = document.createElement('button');
                    btnPlus.className = 'btn-adjust';
                    btnPlus.textContent = '+';
                    btnPlus.setAttribute('aria-label', `Increase ${examLabels[i]} score by 0.5`);
                    btnPlus.addEventListener('click', (e) => {
                        e.preventDefault();
                        handleButtonClick(i, 0.5);
                    });

                    // Score display
                    const scoreDisplay = document.createElement('span');
                    scoreDisplay.className = 'score-display';
                    scoreDisplay.textContent = formatScore(scores[i]);

                    row.appendChild(info);
                    row.appendChild(btnMinus);
                    row.appendChild(slider);
                    row.appendChild(btnPlus);
                    row.appendChild(scoreDisplay);

                    examsContainer.appendChild(row);

                    examRows.push(row);
                    sliders.push(slider);
                    scoreDisplays.push(scoreDisplay);
                    minusButtons.push(btnMinus);
                    plusButtons.push(btnPlus);
                }

                // Divider
                const divider = document.createElement('div');
                divider.className = 'divider';
                examsContainer.appendChild(divider);

                // Final exam row
                const finalRowEl = document.createElement('div');
                finalRowEl.className = 'exam-row final-row';
                finalRowEl.setAttribute('data-index', '6');
                finalRowEl.id = 'finalExamRow';

                const finalInfo = document.createElement('div');
                finalInfo.className = 'exam-info';
                const finalNameSpan = document.createElement('span');
                finalNameSpan.className = 'exam-name';
                finalNameSpan.textContent = 'Final Exam';
                const finalBadge = document.createElement('span');
                finalBadge.className = 'final-badge';
                finalBadge.textContent = 'Final';
                const finalWeightSpan = document.createElement('span');
                finalWeightSpan.className = 'exam-weight';
                finalWeightSpan.id = 'finalWeightSpan';
                finalWeightSpan.textContent = `(weight: ${weights.final})`;
                finalInfo.appendChild(finalNameSpan);
                finalInfo.appendChild(finalBadge);
                finalInfo.appendChild(finalWeightSpan);

                const finalBtnMinus = document.createElement('button');
                finalBtnMinus.className = 'btn-adjust';
                finalBtnMinus.textContent = '−';
                finalBtnMinus.setAttribute('aria-label', 'Decrease Final Exam score by 0.5');
                finalBtnMinus.addEventListener('click', (e) => {
                    e.preventDefault();
                    if (finalEnabled) handleButtonClick(6, -0.5);
                });

                const finalSlider = document.createElement('input');
                finalSlider.type = 'range';
                finalSlider.className = 'slider';
                finalSlider.min = '0';
                finalSlider.max = '100';
                finalSlider.step = '0.5';
                finalSlider.value = scores[6];
                finalSlider.setAttribute('aria-label', 'Final Exam score');
                finalSlider.addEventListener('input', () => handleSliderChange(6));
                finalSlider.addEventListener('change', () => handleSliderChange(6));

                const finalBtnPlus = document.createElement('button');
                finalBtnPlus.className = 'btn-adjust';
                finalBtnPlus.textContent = '+';
                finalBtnPlus.setAttribute('aria-label', 'Increase Final Exam score by 0.5');
                finalBtnPlus.addEventListener('click', (e) => {
                    e.preventDefault();
                    if (finalEnabled) handleButtonClick(6, 0.5);
                });

                const finalScoreDisplay = document.createElement('span');
                finalScoreDisplay.className = 'score-display';
                finalScoreDisplay.textContent = formatScore(scores[6]);

                finalRowEl.appendChild(finalInfo);
                finalRowEl.appendChild(finalBtnMinus);
                finalRowEl.appendChild(finalSlider);
                finalRowEl.appendChild(finalBtnPlus);
                finalRowEl.appendChild(finalScoreDisplay);

                examsContainer.appendChild(finalRowEl);

                // Store final row references
                finalRow = finalRowEl;
                sliders.push(finalSlider);
                scoreDisplays.push(finalScoreDisplay);
                // weightSpans doesn't need the final weight span since we handle it separately
                examRows.push(finalRowEl);
                minusButtons.push(finalBtnMinus);
                plusButtons.push(finalBtnPlus);

                // Apply initial final row state
                updateFinalRowState();
            }

            // ──────────────────────────────────────
            // Toggle weight set
            // ──────────────────────────────────────
            function toggleWeightSet() {
                if (currentWeightSet === 'standard') {
                    currentWeightSet = 'alternative';
                    weightToggleSwitch.classList.add('active');
                    weightToggleCard.classList.add('active-toggle');
                    weightToggleLabel.textContent = weightSets.alternative.label;
                    weightToggleCard.setAttribute('aria-pressed', 'true');
                } else {
                    currentWeightSet = 'standard';
                    weightToggleSwitch.classList.remove('active');
                    weightToggleCard.classList.remove('active-toggle');
                    weightToggleLabel.textContent = weightSets.standard.label;
                    weightToggleCard.setAttribute('aria-pressed', 'false');
                }
                updateWeightLabels();
            }

            // ──────────────────────────────────────
            // Toggle final exam
            // ──────────────────────────────────────
            function toggleFinal() {
                finalEnabled = !finalEnabled;
                updateFinalRowState();
            }

            // ──────────────────────────────────────
            // Event Listeners for toggles
            // ──────────────────────────────────────
            weightToggleCard.addEventListener('click', toggleWeightSet);
            weightToggleCard.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    toggleWeightSet();
                }
            });

            finalToggleCard.addEventListener('click', toggleFinal);
            finalToggleCard.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    toggleFinal();
                }
            });

            // ──────────────────────────────────────
            // Initialize
            // ──────────────────────────────────────
            function init() {
                buildExamRows();
                updateAverage();
                // Set initial toggle states
                weightToggleSwitch.classList.remove('active');
                weightToggleCard.classList.remove('active-toggle');
                weightToggleLabel.textContent = weightSets.standard.label;
                weightToggleCard.setAttribute('aria-pressed', 'false');

                finalToggleSwitch.classList.add('active');
                finalToggleCard.classList.add('active-toggle');
                finalToggleLabel.textContent = 'Final is enabled';
                finalToggleCard.setAttribute('aria-pressed', 'true');
            }

            init();

            console.log('📊 Grade Calculator ready!');
            console.log('  - 6 exams + 1 final exam');
            console.log('  - Sliders with 0.5 step + clickable ± buttons');
            console.log('  - Toggle: Alternative weight set');
            console.log('  - Toggle: Include/Exclude final exam');
            console.log('  - Standard weights: exams [11,9,9,8,11,8] + final 56');
            console.log('  - Alternative weights: exams [96,105,96,74,114,95] + final 580');
        })();
    </script>
</body>
</html>
